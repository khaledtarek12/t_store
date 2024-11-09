import 'package:get/get.dart';
import 'package:t_store/data/repositories/brands/brand_repositry.dart';
import 'package:t_store/features/shop/models/brand_model.module.dart';
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
  // Get Brand Specific Products from your dato source
}
