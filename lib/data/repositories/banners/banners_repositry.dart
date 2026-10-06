import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:t_store/data/services/supabase_storage_service.service.dart';
import 'package:t_store/features/shop/models/banner_model.module.dart';
import 'package:t_store/utils/constants/image_strings.dart';
import 'package:t_store/utils/exceptions/firebase_exception.dart';
import 'package:t_store/utils/exceptions/platform_exception.dart';
import 'package:t_store/utils/popups/full_screen_loader.dart';

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
      TFullScreenLoader.openLoadingDialog('Uploading Data', TImages.loading);
      // Upload all the Categories along with their Images
      final storage = Get.put(TSupabaseStorageService());

      // Loop through each category
      for (var banner in banners) {
        // Upload Image and Get its URL
        final url = await storage.uploadAsset('Banners', banner.imageUrl);

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
      throw 'somethinq went wrong. Please try again : $e';
    } finally {
      TFullScreenLoader.stopLoading();
    }
  }
}
