import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:t_store/data/services/firebase_storage_service.service.dart';
import 'package:t_store/features/shop/models/brand_model.module.dart';
import 'package:t_store/features/shop/models/relashtions/brand_category_model.module.dart';
import 'package:t_store/utils/constants/image_strings.dart';
import 'package:t_store/utils/exceptions/firebase_exception.dart';
import 'package:t_store/utils/exceptions/platform_exception.dart';
import 'package:t_store/utils/popups/full_screen_loader.dart';
import 'package:t_store/utils/popups/loaders.dart';

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
      throw 'somethinq went wrong. Please try again:\n $e';
    }
  }

  // Get Brands for Category
  Future<List<BrandModel>> getBrandForCategory(categoryId) async {
    try {
      // Query to get all documents where category ld matches the provided categoryId
      QuerySnapshot brandCateogryQuery = await dataBase
          .collection('BrandCategory')
          .where('categoryId', isEqualTo: categoryId)
          .get();

      // Extract brandlds from the documents
      List<String> barndIds = brandCateogryQuery.docs
          .map((doc) => doc['brandId'] as String)
          .toList();

      // Query to get all documents where the brandId is in the list of brandIds, FieldPath.documentId to query documents in Collection
      final barndQuery = await dataBase
          .collection('Brands')
          .where(FieldPath.documentId, whereIn: barndIds)
          .limit(2)
          .get();

      List<BrandModel> brands =
          barndQuery.docs.map((doc) => BrandModel.fromSnapshot(doc)).toList();

      return brands;
    } on FirebaseException catch (e) {
      throw TFirebaseException(code: e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(code: e.code).message;
    } catch (e) {
      throw 'somethinq went wrong. Please try again:\n $e';
    }
  }

  Future<void> uploadBrandsCategoriesRelationData(
      List<BrandCategoryModel> brandCategories) async {
    TFullScreenLoader.openLoadingDialog('Start Uploading...', TImages.loading);
    final CollectionReference brandCategoryCollection =
        dataBase.collection('BrandCategory');

    try {
      for (var brandCategory in brandCategories) {
        await brandCategoryCollection.add(brandCategory.toJson());
        log("Uploaded ${brandCategory.brandId} - ${brandCategory.categoryId}");
      }
    } catch (e) {
      log("Error uploading data: $e");
      TLoaders.errorSnakBar(title: 'Error uploading', message: e.toString());
    } finally {
      TFullScreenLoader.stopLoading();
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
