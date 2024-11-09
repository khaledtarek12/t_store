import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_store/data/repositories/product/product_repositry.dart';
import 'package:t_store/features/shop/models/product_model.module.dart';
import 'package:t_store/utils/popups/loaders.dart';

class AllProductController extends GetxController {
  static AllProductController get instance => Get.find();

  final repositry = ProductRepositry.instance;
  final ValueNotifier<String> selectedSortOption =
      ValueNotifier<String>('Name');
  final RxList<ProductModel> products = <ProductModel>[].obs;

  Future<List<ProductModel>> fetchProductsByQuery(Query? query) async {
    try {
      if (query == null) return [];

      final product = repositry.fetchProductsByQuery(query);

      return product;
    } catch (e) {
      TLoaders.errorSnakBar(title: 'Oh Snap!', message: e.toString());
      return [];
    }
  }

  void sortProducts(String sortOption) {
    selectedSortOption.value = sortOption;

    switch (sortOption) {
      case 'Name':
        products.sort((a, b) => a.title.compareTo(b.title));
        log("Sorting by Name");
        break;

      case 'Higher Price':
        products.sort((a, b) => b.price.compareTo(a.price));
        log("Sorting by Higher Price");
        break;

      case 'Lower Price':
        products.sort((a, b) => a.price.compareTo(b.price));
        log("Sorting by Lower Price");
        break;

      case 'Sale':
        products.sort((a, b) {
          if (b.salePrice > 0) {
            return b.salePrice.compareTo(a.salePrice);
          } else if (a.salePrice > 0) {
            return -1;
          } else {
            return 1;
          }
        });
        log("Sorting by Sale");
        break;

      default:
        products.sort((a, b) => a.title.compareTo(b.title));
    }
  }

  void assignProducts(List<ProductModel> products) {
    this.products.assignAll(products);
    sortProducts('Name');
  }
}
