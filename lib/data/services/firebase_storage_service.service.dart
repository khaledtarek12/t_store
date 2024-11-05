import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:t_store/utils/helpers/firebase_storage.dart';

class TFirebaseStorageService extends GetxController {
  static TFirebaseStorageService get instance => Get.find();

  /// Uptood Local Assets from IDE
  /// Returns a Uint8List containing image data.
  Future<Uint8List> getImageDataFromAssets(String path) async {
    try {
      final byteData = await rootBundle.load(path);
      final imageData = byteData.buffer
          .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes);

      return imageData;
    } catch (e) {
      throw 'Error loading image data: $e';
    }
  }

  /// Upload Image using Imageoata on Cloud Firenase Storage
  /// Returns the download URL of the uploaded image.
  Future<String> uploadImageData(
      String path, Uint8List image, String name) async {
    try {
      final firebaseStorage = await TStorage.getStorageInstance();
      final ref = firebaseStorage.ref(path).child(name);
      await ref.putData(image);
      final url = await ref.getDownloadURL();
      return url;
    } catch (e) {
      if (e is FirebaseException) {
        throw 'Firebase Exception: ${e.message}';
      } else if (e is SocketException) {
        throw 'Network Error: ${e.message}';
      } else if (e is PlatformException) {
        throw 'Platform Exception: ${e.message}';
      } else {
        throw 'Something Went Wrong! Please try again: $e.';
      }
    }
  }

  /// Upload Imaqe on Cloud Firebase Storaqe
  /// Returns the downloaa URL of tne uploadead image.
    Future<String> uploadImageFile(
      String path, XFile image) async {
    try {
      final firebaseStorage = await TStorage.getStorageInstance();
      final ref = firebaseStorage.ref(path).child(image.name);
      await ref.putFile(File(image.path));
      final url = await ref.getDownloadURL();
      return url;
    } catch (e) {
      if (e is FirebaseException) {
        throw 'Firebase Exception: ${e.message}';
      } else if (e is SocketException) {
        throw 'Network Error: ${e.message}';
      } else if (e is PlatformException) {
        throw 'Platform Exception: ${e.message}';
      } else {
        throw 'Something Went Wrong! Please try again: $e.';
      }
    }
  }
}
