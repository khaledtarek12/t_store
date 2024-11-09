import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:t_store/data/services/firebase_storage_service.service.dart';
import 'package:t_store/features/shop/models/brand_model.module.dart';
import 'package:t_store/utils/constants/image_strings.dart';
import 'package:t_store/utils/exceptions/firebase_exception.dart';
import 'package:t_store/utils/exceptions/platform_exception.dart';
import 'package:t_store/utils/popups/full_screen_loader.dart';

class BrandRepositry extends GetxController {
  static BrandRepositry get instance => Get.find();

  // vraiables
  final dataBase = FirebaseFirestore.instance;

  //  Get all categories
  Future<List<BrandModel>> getAllBrands() async {
    try {
      final snapshot = await dataBase.collection('Brands').get();

      final result = snapshot.docs
          .map((element) => BrandModel.fromSnapshot(element))
          .toList();

      return result;
    } on FirebaseException catch (e) {
      throw TFirebaseException(code: e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(code: e.code).message;
    } catch (e) {
      throw 'somethinq went wrong. Please try again';
    }
  }

  /// Upload Banners to the Cloud Firebase
  Future<void> uploadDummyData(List<BrandModel> brands) async {
    if (brands.isEmpty) {
      throw 'No brands to upload.';
    }

    try {
      TFullScreenLoader.openLoadingDialog('Uploading Data...', TImages.loading);
      final storage = Get.put(TFirebaseStorageService());

      for (var brand in brands) {
        // Check if the brand image path is valid
        if (brand.image.isEmpty) {
          throw 'Image path is missing for brand ${brand.name}';
        }

        // Attempt to get image data
        final file = await storage.getImageDataFromAssets(brand.image);

        // Upload image data and get URL
        final url = await storage.uploadImageData('Brands', file, brand.image);
        if (url.isEmpty) {
          throw 'Failed to upload image for ${brand.name}';
        }

        // Assign URL to brand's image attribute
        brand.image = url;

        // Store the brand in Firestore
        await dataBase.collection('Brands').doc(brand.id).set(brand.toJson());
      }
    } on FirebaseException catch (e) {
      throw TFirebaseException(code: e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(code: e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again: $e';
    } finally {
      TFullScreenLoader.stopLoading();
    }
  }
}
