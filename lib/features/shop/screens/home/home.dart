import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_store/common/layouts/grid_layout.dart';
import 'package:t_store/common/shammer/shammer_grid.dart';
import 'package:t_store/common/widgets/custom_shapes/container/primary_header_container.dart';
import 'package:t_store/common/widgets/custom_shapes/container/search_container.dart';
import 'package:t_store/common/widgets/texts/seaction_heading.dart';
import 'package:t_store/features/shop/controllers/products/product_controller.dart';
import 'package:t_store/features/shop/screens/all_product/all_prodcut.dart';
import 'package:t_store/features/shop/screens/home/widgets/home_appbar.dart';
import 'package:t_store/features/shop/screens/home/widgets/home_categroy.dart';
import 'package:t_store/common/widgets/products/product_cards/product_cart_virtical.dart';
import 'package:t_store/features/shop/screens/home/widgets/promo_slider.dart';
import 'package:t_store/utils/constants/sizes.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProductController());
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const TPrimaryHeaderContainer(
              chilld: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //App bar
                  THomeAppBar(),
                  SizedBox(height: TSizes.spaceBtwScetions),

                  //Search bar
                  TSearchContainer(text: 'Search in Store'),
                  SizedBox(height: TSizes.spaceBtwScetions),

                  //Categories
                  THomeCategroy(),
                  SizedBox(height: TSizes.spaceBtwScetions * 1.5),
                ],
              ),
            ),
            Column(
              children: [
                const SizedBox(height: TSizes.spaceBtwItems),
                //promo slider
                const TpromoSlider(),

                //heading
                Padding(
                  padding: const EdgeInsets.all(TSizes.defultSpace),
                  child: Column(
                    children: [
                      TSectionHeading(
                        title: 'Popular Products',
                        onPressed: () => Get.to(
                          () => AllProdcutScreen(
                            title: 'Popular Products',
                            futureMethod: controller.fetchAllFeaturedProducts(),
                          ),
                        ),
                      ),
                      const SizedBox(height: TSizes.spaceBtwItems),

                      //popular product
                      Obx(() {
                        if (controller.loading.value) {
                          return const TVerticalProductShimmer();
                        }

                        if (controller.featuredProducts.isEmpty) {
                          return Center(
                              child: Text('No Data Found!',
                                  style:
                                      Theme.of(context).textTheme.bodyMedium));
                        }
                        return TGridLayout(
                          itemCount: controller.featuredProducts.length,
                          itemBuilder: (context, index) => TProductCartVertical(
                            product: controller.featuredProducts[index],
                          ),
                        );
                      }),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
