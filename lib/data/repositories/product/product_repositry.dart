import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:t_store/data/services/firebase_storage_service.service.dart';
import 'package:t_store/features/shop/models/product_model.module.dart';
import 'package:t_store/features/shop/models/relashtions/product_category_model.module.dart';
import 'package:t_store/utils/constants/enums.dart';
import 'package:t_store/utils/constants/image_strings.dart';
import 'package:t_store/utils/exceptions/firebase_exception.dart';
import 'package:t_store/utils/exceptions/platform_exception.dart';
import 'package:t_store/utils/popups/full_screen_loader.dart';
import 'package:t_store/utils/popups/loaders.dart';

class ProductRepositry extends GetxController {
  static ProductRepositry get instance => Get.find();

  /// Firestore instance for database interactions.
  final dataBase = FirebaseFirestore.instance;

  /// Get limited featured products
  Future<List<ProductModel>> getFeaturedProducts() async {
    try {
      final snapShot = await dataBase
          .collection('Products')
          .where('IsFeatured', isEqualTo: true)
          .limit(4)
          .get();
      return snapShot.docs.map((e) => ProductModel.fromSnapshot(e)).toList();
    } on FirebaseException catch (e) {
      throw TFirebaseException(code: e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(code: e.code).message;
    } catch (e) {
      throw 'somethinq went wrong. Please try again';
    }
  }

  /// Get limited featured products
  Future<List<ProductModel>> getAllFeaturedProducts() async {
    try {
      final snapShot = await dataBase
          .collection('Products')
          .where('IsFeatured', isEqualTo: true)
          .get();
      return snapShot.docs.map((e) => ProductModel.fromSnapshot(e)).toList();
    } on FirebaseException catch (e) {
      throw TFirebaseException(code: e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(code: e.code).message;
    } catch (e) {
      throw 'somethinq went wrong. Please try again';
    }
  }

  /// Get Products based on the Query
  Future<List<ProductModel>> fetchProductsByQuery(Query query) async {
    try {
      final querySnapshot = await query.get();
      final List<ProductModel> productList = querySnapshot.docs
          .map((doc) => ProductModel.fromQuerySnapshot(doc))
          .toList();
      return productList;
    } on FirebaseException catch (e) {
      throw TFirebaseException(code: e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(code: e.code).message;
    } catch (e) {
      throw 'somethinq went wrong. Please try again';
    }
  }

  /// Get Products based on the Query
  Future<List<ProductModel>> getFavouriteProduct(
      List<String> productIds) async {
    try {
      // Check if productIds list is empty
      if (productIds.isEmpty) {
        return []; // Return an empty list if there are no product IDs
      }

      final snapshot = await dataBase
          .collection('Products')
          .where(FieldPath.documentId, whereIn: productIds)
          .get();

      return snapshot.docs
          .map((doc) => ProductModel.fromSnapshot(doc))
          .toList();
    } on FirebaseException catch (e) {
      throw TFirebaseException(code: e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(code: e.code).message;
    } catch (e) {
      log(e.toString());
      throw 'Something went wrong. Please try again.\n$e';
    }
  }

  Future<List<ProductModel>> getProductsForBrand(
      {required String brandId, int limit = -1}) async {
    try {
      final querySnapshot = limit == -1
          ? await dataBase
              .collection('Products')
              .where('Brand.Id', isEqualTo: brandId)
              .get()
          : await dataBase
              .collection('Products')
              .where('Brand.Id', isEqualTo: brandId)
              .limit(limit)
              .get();

      final products =
          querySnapshot.docs.map((e) => ProductModel.fromSnapshot(e)).toList();

      return products;
    } on FirebaseException catch (e) {
      throw TFirebaseException(code: e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(code: e.code).message;
    } catch (e) {
      throw 'somethinq went wrong. Please try again';
    }
  }

  Future<List<ProductModel>> getProductsForCateogry(
      {required String categoryId, int limit = -1}) async {
    try {
      // Query to get alt documents wnere product ld matcnes the provided categoryld & Fetch limited or unlimited based on limit
      final productCategoryQuery = limit == -1
          ? await dataBase
              .collection('ProductCategory')
              .where('categoryId', isEqualTo: categoryId)
              .get()
          : await dataBase
              .collection('ProductCategory')
              .where('categoryId', isEqualTo: categoryId)
              .limit(limit)
              .get();

      // Extract product Ids from the documents
      List<String> productIds = productCategoryQuery.docs
          .map((doc) => doc['productId'] as String)
          .toList();

      // Query to get all documents where the brand ld is in the list of brandlds, FieldPath.documentId to query documents in Collection
      final productQuery = await dataBase
          .collection('Products')
          .where(FieldPath.documentId, whereIn: productIds)
          .get();
      final List<ProductModel> products = productQuery.docs
          .map((doc) => ProductModel.fromSnapshot(doc))
          .toList();

      return products;
    } on FirebaseException catch (e) {
      throw TFirebaseException(code: e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(code: e.code).message;
    } catch (e) {
      throw 'somethinq went wrong. Please try again \n $e';
    }
  }

  Future<void> uploadProductCategoriesRelationData(
      List<ProductCategoryModel> brandCategories) async {
    TFullScreenLoader.openLoadingDialog('Start Uploading...', TImages.loading);
    final CollectionReference productCategoryCollection =
        dataBase.collection('ProductCategory');

    try {
      for (var productCategory in brandCategories) {
        await productCategoryCollection.add(productCategory.toJson());
        log("Uploaded ${productCategory.productId} - ${productCategory.categoryId}");
      }
    } catch (e) {
      log("Error uploading data: $e");
      TLoaders.errorSnakBar(title: 'Error uploading', message: e.toString());
    } finally {
      TFullScreenLoader.stopLoading();
    }
  }

  /// Upload dummy data to the Cloud Firebase
  Future<void> uploadDummyData(List<ProductModel> products) async {
    // Upload all the products along with their images
    try {
      TFullScreenLoader.openLoadingDialog(
          'UpLoading Data.....', TImages.loading);

      final storage = Get.put(TFirebaseStorageService());

      for (var product in products) {
        // Get image data link from local assets
        final thumbnail =
            await storage.getImageDataFromAssets(product.thumbanil);

        // Upload image and get its URL
        final url = await storage.uploadImageData(
            'Products/Images', thumbnail, product.thumbanil.toString());

        // Assign URL to product. thumbnail attribute
        product.thumbanil = url;

        // Product list of images
        if (product.images != null && product.images!.isNotEmpty) {
          List<String> imagesUrl = [];
          for (var image in product.images!) {
            // Get image data link from local assets
            final assetsImage = await storage.getImageDataFromAssets(image);

            // Upload image and get its URL
            final url = await storage.uploadImageData(
                'Products/Images', assetsImage, image);

            imagesUrl.add(url);
          }
          product.images!.clear();
          product.images!.addAll(imagesUrl);
        }

        // Upload Variation Images
        if (product.productType == ProductType.variable.toString()) {
          for (var variation in product.productVariations!) {
            // Get image data tink from locat assets
            final assetImage =
                await storage.getImageDataFromAssets(variation.image);

            // Upload image and get its URL
            final url = await storage.uploadImageData(
                'Products/Images', assetImage, variation.image);

            variation.image = url;
          }
        }

        await dataBase
            .collection("Products")
            .doc(product.id)
            .set(product.toJson());
      }
    } on FirebaseException catch (e) {
      throw TFirebaseException(code: e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(code: e.code).message;
    } catch (e) {
      throw 'somethinq went wrong. Please try again';
    } finally {
      TFullScreenLoader.stopLoading();
    }
  }
}
