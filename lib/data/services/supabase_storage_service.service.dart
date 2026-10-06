import 'dart:io';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:t_store/utils/constants/supabase_constants.dart';

/// Image storage backed by Supabase Storage.
///
/// Exposes the same API as [TFirebaseStorageService] so repositories can swap
/// between the two without any other change. Uploads are authorised by the
/// Firebase ID token that is handed to Supabase in `main.dart`, so Storage
/// policies see the Firebase uid as `auth.jwt() ->> 'sub'`.
class TSupabaseStorageService extends GetxController {
  static TSupabaseStorageService get instance => Get.find();

  StorageFileApi get _bucket {
    if (!TSupabase.isConfigured) {
      throw 'Supabase is not configured. Pass SUPABASE_URL and '
          'SUPABASE_PUBLISHABLE_KEY with --dart-define.';
    }
    return Supabase.instance.client.storage.from(TSupabase.imagesBucket);
  }

  /// Reads an image that ships inside the app bundle.
  /// Returns a Uint8List containing image data.
  Future<Uint8List> getImageDataFromAssets(String path) async {
    try {
      final byteData = await rootBundle.load(path);
      return byteData.buffer
          .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes);
    } catch (e) {
      throw 'Error loading image data: $e';
    }
  }

  /// Uploads raw bytes to `<path>/<name>` and returns the public URL.
  Future<String> uploadImageData(
      String path, Uint8List image, String name) async {
    // Callers sometimes pass a name with no extension (categories use the
    // category name), so fall back to sniffing the real format from the bytes.
    final contentType = _contentTypeFor(name) ?? _sniffContentType(image);
    final objectPath = _objectPath(path, name, contentType: contentType);
    try {
      await _bucket.uploadBinary(
        objectPath,
        image,
        fileOptions: FileOptions(
          upsert: true,
          contentType: contentType,
          cacheControl: _cacheControl,
        ),
      );
      return _bucket.getPublicUrl(objectPath);
    } catch (e) {
      throw _describe(e);
    }
  }

  /// Uploads a bundled asset and returns its public URL.
  ///
  /// Seeding writes the resulting URL back onto the shared `TDummyData`
  /// models, which live for the whole session, so a second run hands this
  /// method a URL instead of an asset path. Returning it unchanged keeps the
  /// "Upload Data" buttons safe to press more than once.
  Future<String> uploadAsset(String path, String assetPath,
      {String? name}) async {
    if (assetPath.startsWith('http')) return assetPath;
    final bytes = await getImageDataFromAssets(assetPath);
    return uploadImageData(path, bytes, name ?? assetPath);
  }

  /// Uploads a picked file to `<path>/<file name>` and returns the public URL.
  Future<String> uploadImageFile(String path, XFile image) async {
    final objectPath = _objectPath(path, image.name);
    try {
      await _bucket.upload(
        objectPath,
        File(image.path),
        fileOptions: FileOptions(
          upsert: true,
          contentType:
              image.mimeType ?? _contentTypeFor(image.name) ?? 'image/jpeg',
          cacheControl: _cacheControl,
        ),
      );
      return _bucket.getPublicUrl(objectPath);
    } catch (e) {
      throw _describe(e);
    }
  }

  /// Removes a previously uploaded object. Accepts the public URL or the
  /// object path, so callers can delete an old avatar before replacing it.
  Future<void> deleteFile(String urlOrPath) async {
    try {
      await _bucket.remove([_pathFromUrl(urlOrPath)]);
    } catch (e) {
      throw _describe(e);
    }
  }

  /// Images are content-addressed by name and overwritten on change, so they
  /// can be cached aggressively (one year) by the CDN and the device.
  static const String _cacheControl = '31536000';

  /// Builds a clean object key. Callers pass asset paths as the file name
  /// (for example `assets/images/product_cart/shoe.png`), so only the file
  /// name itself is kept to avoid deeply nested keys.
  String _objectPath(String folder, String name, {String? contentType}) {
    final cleanFolder = folder.replaceAll(RegExp(r'^/+|/+$'), '');
    final fileName = name.split(RegExp(r'[/\\]')).last;
    var safeName = fileName.replaceAll(RegExp(r'[^A-Za-z0-9._-]'), '_');
    if (_contentTypeFor(safeName) == null && contentType != null) {
      safeName = '$safeName${_extensionFor(contentType)}';
    }
    return cleanFolder.isEmpty ? safeName : '$cleanFolder/$safeName';
  }

  String _pathFromUrl(String urlOrPath) {
    const marker = '/object/public/';
    final index = urlOrPath.indexOf(marker);
    if (index == -1) return urlOrPath;
    final afterMarker = urlOrPath.substring(index + marker.length);
    // Strip the leading bucket segment to get the key inside the bucket.
    final firstSlash = afterMarker.indexOf('/');
    return firstSlash == -1
        ? afterMarker
        : afterMarker.substring(firstSlash + 1);
  }

  /// Returns null when the name carries no recognisable image extension.
  String? _contentTypeFor(String name) {
    if (!name.contains('.')) return null;
    switch (name.split('.').last.toLowerCase()) {
      case 'png':
        return 'image/png';
      case 'jpg':
      case 'jpeg':
        return 'image/jpeg';
      case 'gif':
        return 'image/gif';
      case 'webp':
        return 'image/webp';
      case 'svg':
        return 'image/svg+xml';
      default:
        return null;
    }
  }

  /// Identifies the format from the file signature.
  String _sniffContentType(Uint8List bytes) {
    bool startsWith(List<int> magic, {int offset = 0}) {
      if (bytes.length < offset + magic.length) return false;
      for (var i = 0; i < magic.length; i++) {
        if (bytes[offset + i] != magic[i]) return false;
      }
      return true;
    }

    if (startsWith([0x89, 0x50, 0x4E, 0x47])) return 'image/png';
    if (startsWith([0xFF, 0xD8, 0xFF])) return 'image/jpeg';
    if (startsWith([0x47, 0x49, 0x46])) return 'image/gif';
    if (startsWith([0x52, 0x49, 0x46, 0x46]) &&
        startsWith([0x57, 0x45, 0x42, 0x50], offset: 8)) {
      return 'image/webp';
    }
    return 'application/octet-stream';
  }

  String _extensionFor(String contentType) {
    switch (contentType) {
      case 'image/png':
        return '.png';
      case 'image/jpeg':
        return '.jpg';
      case 'image/gif':
        return '.gif';
      case 'image/webp':
        return '.webp';
      case 'image/svg+xml':
        return '.svg';
      default:
        return '';
    }
  }

  String _describe(Object e) {
    if (e is StorageException) {
      // A 403 here almost always means the Firebase token is missing the
      // `role: authenticated` custom claim, so Supabase treated it as anon.
      return 'Storage Error: ${e.message}';
    } else if (e is SocketException) {
      return 'Network Error: ${e.message}';
    } else if (e is PlatformException) {
      return 'Platform Exception: ${e.message}';
    }
    return 'Something Went Wrong! Please try again: $e.';
  }
}
