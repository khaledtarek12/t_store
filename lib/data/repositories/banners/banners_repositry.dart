import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:t_store/data/services/firebase_storage_service.service.dart';
import 'package:t_store/features/shop/models/banner_model.module.dart';
import 'package:t_store/utils/exceptions/firebase_exception.dart';
import 'package:t_store/utils/exceptions/platform_exception.dart';

class BannersRepositry extends GetxController {
  static BannersRepositry get instance => Get.find();

  // variables
  final dataBase = FirebaseFirestore.instance;

  /// Get all order related to current User
  Future<List<BannerModel>> fetchBanners() async {
    try {
      final result = await dataBase
          .collection('Banners')
          .where('Active', isEqualTo: true)
          .get();

      return result.docs
          .map((documentSnapshot) => BannerModel.fromSnapshot(documentSnapshot))
          .toList();
    } on FirebaseException catch (e) {
      throw TFirebaseException(code: e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(code: e.code).message;
    } catch (e) {
      throw 'somethinq went wrong while fetchin Banners. Please try again';
    }
  }

  /// Upload Banners to the Cloud Firebase
  Future<void> uploadDummyData(List<BannerModel> banners) async {
    try {
      // Upload all the Categories along with their Images
      final storage = Get.put(TFirebaseStorageService());

      // Loop through each category
      for (var banner in banners) {
        // Get Imagedata link from the local assets
        final file = await storage.getImageDataFromAssets(banner.imageUrl);

        // Upload Image and Get its URL
        final url =
            await storage.uploadImageData('Banners', file, banner.imageUrl);

        // Assign URL to Category. image attribute
        banner.imageUrl = url;

        // Store Category in Firestore
        await dataBase.collection('Banners').doc().set(banner.toJson());
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
