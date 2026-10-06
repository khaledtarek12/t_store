import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:t_store/data/services/supabase_storage_service.service.dart';
import 'package:t_store/features/shop/models/category_model.module.dart';
import 'package:t_store/utils/constants/image_strings.dart';
import 'package:t_store/utils/exceptions/firebase_exception.dart';
import 'package:t_store/utils/exceptions/platform_exception.dart';
import 'package:t_store/utils/popups/full_screen_loader.dart';

class CategoryRepositry extends GetxController {
  static CategoryRepositry get instance => Get.find();

  // variables
  final dataBase = FirebaseFirestore.instance;

  // Get all cotegories
  Future<List<CategoryModel>> getAllCategories() async {
    try {
      final snapShot = await dataBase.collection('Categories').get();
      final listofCategories = snapShot.docs
          .map((element) => CategoryModel.fromSnapshot(element))
          .toList();

      return listofCategories;
    } on FirebaseException catch (e) {
      throw TFirebaseException(code: e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(code: e.code).message;
    } catch (e) {
      throw 'somethinq went wrong. Please try again';
    }
  }

  // Get Sub Categories
  Future<List<CategoryModel>> getSubCategory(
      {required String categoryId}) async {
    try {
      final snapShot = await dataBase
          .collection('Categories')
          .where('ParentId', isEqualTo: categoryId)
          .get();
      final result = snapShot.docs
          .map((element) => CategoryModel.fromSnapshot(element))
          .toList();

      return result;
    } on FirebaseException catch (e) {
      throw TFirebaseException(code: e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(code: e.code).message;
    } catch (e) {
      throw 'somethinq went wrong. Please try again \n $e';
    }
  }

  // Upload Categories to the Cloud Firebase
  Future<void> uploadDummyData(List<CategoryModel> categories) async {
    try {
      TFullScreenLoader.openLoadingDialog('Uploading Data', TImages.loading);
      // Upload all the Categories along with their Images
      final storage = Get.put(TSupabaseStorageService());

      // Loop through each category
      for (var category in categories) {
        // Upload Image and Get its URL
        final url = await storage.uploadAsset('Categories', category.image,
            name: category.name);

        // Assign URL to Category. image attribute
        category.image = url;

        // Store Category in Firestore
        await dataBase
            .collection('Categories')
            .doc(category.id)
            .set(category.toJson());
      }
    } on FirebaseException catch (e) {
      throw TFirebaseException(code: e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(code: e.code).message;
    } catch (e) {
      throw 'somethinq went wrong. Please try again : $e';
    } finally {
      TFullScreenLoader.stopLoading();
    }
  }
}
