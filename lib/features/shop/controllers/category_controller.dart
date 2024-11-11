import 'package:get/get.dart';
import 'package:t_store/data/repositories/categories/category_repositry.dart';
import 'package:t_store/data/repositories/product/product_repositry.dart';
import 'package:t_store/features/shop/models/category_model.module.dart';
import 'package:t_store/features/shop/models/product_model.module.dart';
import 'package:t_store/utils/popups/loaders.dart';

class CategoryController extends GetxController {
  static CategoryController get instance => Get.find();

  final isLoading = false.obs;
  final categoryRepositry = Get.put(CategoryRepositry());
  RxList<CategoryModel> allCateogries = <CategoryModel>[].obs;
  RxList<CategoryModel> featuredCateogries = <CategoryModel>[].obs;

  @override
  void onInit() {
    fetchCategories();
    super.onInit();
  }

  // Load category data
  Future<void> fetchCategories() async {
    try {
      // show loader while loading categories
      isLoading.value = true;

      // Fetch categories from data source (Fires tore, API, etc.)
      final categories = await categoryRepositry.getAllCategories();

      // Update the categories list
      allCateogries.assignAll(categories);

      // Filter featured categories
      featuredCateogries.assignAll(
        categories
            .where((element) => element.isFeatured && element.parentId.isEmpty)
            .take(8)
            .toList(),
      );
    } catch (e) {
      TLoaders.errorSnakBar(title: 'Oh Snap!', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  // Load selected category data

  // Get Category or Sub-Category Products.
  Future<List<ProductModel>> getCategoryProducts(
      {required String categoryId, int limit = -1}) async {
    // Fetch limited (4) products against each subCateqory,
    final products = await ProductRepositry.instance
        .getProductsForCateogry(categoryId: categoryId, limit: limit);
    return products;
  }
}
