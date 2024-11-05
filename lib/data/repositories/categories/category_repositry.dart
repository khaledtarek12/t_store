import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:t_store/data/services/firebase_storage_service.service.dart';
import 'package:t_store/features/shop/models/category_model.module.dart';
import 'package:t_store/utils/exceptions/firebase_exception.dart';
import 'package:t_store/utils/exceptions/platform_exception.dart';

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

  // Upload Categories to the Cloud Firebase
  Future<void> uploadDummyData(List<CategoryModel> categories) async {
    try {
      // Upload all the Categories along with their Images
      final storage = Get.put(TFirebaseStorageService());

      // Loop through each category
      for (var category in categories) {
        // Get Imagedata link from the local assets
        final file = await storage.getImageDataFromAssets(category.image);

        // Upload Image and Get its URL
        final url =
            await storage.uploadImageData('Categories', file, category.name);

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
      throw 'somethinq went wrong. Please try again';
    }
  }
}
