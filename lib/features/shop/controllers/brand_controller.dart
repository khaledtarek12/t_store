import 'package:get/get.dart';
import 'package:t_store/data/repositories/brands/brand_repositry.dart';
import 'package:t_store/data/repositories/product/product_repositry.dart';
import 'package:t_store/features/shop/models/brand_model.module.dart';
import 'package:t_store/features/shop/models/product_model.module.dart';
import 'package:t_store/utils/popups/loaders.dart';

class BrandController extends GetxController {
  static BrandController get instance => Get.find();

  final isLoading = true.obs;
  final RxList<BrandModel> allBrands = <BrandModel>[].obs;
  final RxList<BrandModel> featureBrand = <BrandModel>[].obs;

  final barndRepositry = Get.put(BrandRepositry());

  @override
  void onInit() {
    getFeatureBrands();
    super.onInit();
  }

  // Load Brands
  Future<void> getFeatureBrands() async {
    try {
      isLoading.value = true;

      final brands = await barndRepositry.getAllBrands();

      allBrands.assignAll(brands);

      featureBrand.assignAll(allBrands
          .where(
            (brand) => brand.isFeatured ?? false,
          )
          .take(4));
    } catch (e) {
      TLoaders.errorSnakBar(title: 'Oh Snap!', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  // Get Brands For Category
  Future<List<BrandModel>> getBrandForCategory(String categoryId) async {
    try {
      final brands =
          await BrandRepositry.instance.getBrandForCategory(categoryId);

      return brands;
    } catch (e) {
      TLoaders.errorSnakBar(title: 'Oh Snap!', message: e.toString());
      return [];
    }
  }

  // Get Brand Specific Products from your dato source
  Future<List<ProductModel>> getBrandProducts(
      {required String brandId, int limit = -1}) async {
    try {
      final products = await ProductRepositry.instance
          .getProductsForBrand(brandId: brandId, limit: limit);

      return products;
    } catch (e) {
      TLoaders.errorSnakBar(title: 'Oh Snap!', message: e.toString());
      return [];
    }
  }
}
