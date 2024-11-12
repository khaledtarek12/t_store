import 'dart:convert';

import 'package:get/get.dart';
import 'package:t_store/data/repositories/product/product_repositry.dart';
import 'package:t_store/features/shop/models/product_model.module.dart';
import 'package:t_store/utils/local_storage/storage_utility.dart';
import 'package:t_store/utils/popups/loaders.dart';

class FavouriteController extends GetxController {
  static FavouriteController get instance => Get.find();

  // variables
  final favourites = <String, bool>{}.obs;

  @override
  void onInit() {
    super.onInit();
    initFavourite();
  }

  void initFavourite() {
    final json = TLocalStorage.instance().readData('favourites');
    if (json != null) {
      final storageFavourites = jsonDecode(json) as Map<String, dynamic>;
      favourites.assignAll(storageFavourites.map(
        (key, value) => MapEntry(key, value as bool),
      ));
    }
  }

  bool isFavourite(String productId) {
    return favourites[productId] ?? false;
  }

  void toggleFavouriteProducts(String productId) {
    if (!favourites.containsKey(productId)) {
      favourites[productId] = true;
      saveFavouritesToStorage();
      TLoaders.customToast(message: 'Product has been added to the Wishlist.');
    } else {
      TLocalStorage.instance().removeData(productId);
      favourites.remove(productId);
      saveFavouritesToStorage();
      favourites.refresh();
      TLoaders.customToast(
          message: 'Product has been removed from the Wishlist.');
    }
  }

  void saveFavouritesToStorage() {
    final encodeFavourites = json.encode(favourites);
    TLocalStorage.instance().saveData('favourites', encodeFavourites);
  }

  Future<List<ProductModel>> favoriteProduct() async {
    return await ProductRepositry.instance
        .getFavouriteProduct(favourites.keys.toList());
  }
}
