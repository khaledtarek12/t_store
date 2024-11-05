import 'package:get/get.dart';
import 'package:t_store/data/repositories/banners/banners_repositry.dart';
import 'package:t_store/features/shop/models/banner_model.module.dart';
import 'package:t_store/utils/popups/loaders.dart';

class BannerController extends GetxController {
  static BannerController get incstance => Get.find();

  // variables
  final carsoualCurrentIndex = 0.obs;
  final imageLoading = false.obs; // Start with loading as true
  final RxList<BannerModel> banners = <BannerModel>[].obs;

  @override
  void onInit() {
    fetchBanners();
    super.onInit();
  }

  /// Update Poge Navigationot Dots
  void updatePageIndicator(int index) {
    carsoualCurrentIndex.value = index;
  }

  // FetchBanners
  Future<void> fetchBanners() async {
    try {
      // show loader while loading categories
      imageLoading.value = true;

      // Fetch Banners
      final bannerRepo = Get.put(BannersRepositry());
      final banners = await bannerRepo.fetchBanners();

      this.banners.assignAll(banners);
    } catch (e) {
      TLoaders.errorSnakBar(title: 'Oh Snap!', message: e.toString());
    } finally {
      imageLoading.value = false;
    }
  }
}
