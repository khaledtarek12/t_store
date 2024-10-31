import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_store/common/layouts/grid_layout.dart';
import 'package:t_store/common/widgets/custom_shapes/container/primary_header_container.dart';
import 'package:t_store/common/widgets/custom_shapes/container/search_container.dart';
import 'package:t_store/common/widgets/texts/seaction_heading.dart';
import 'package:t_store/features/shop/screens/all_product/all_prodcut.dart';
import 'package:t_store/features/shop/screens/home/widgets/home_appbar.dart';
import 'package:t_store/features/shop/screens/home/widgets/home_categroy.dart';
import 'package:t_store/common/widgets/products/product_cards/product_cart_virtical.dart';
import 'package:t_store/features/shop/screens/home/widgets/promo_slider.dart';
import 'package:t_store/navigation_menu.dart';
import 'package:t_store/utils/constants/image_strings.dart';
import 'package:t_store/utils/constants/sizes.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = NavigationController.instance;

    return Scaffold(
      body: SingleChildScrollView(
        controller: controller.scrollController,
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
            Padding(
              padding: const EdgeInsets.all(TSizes.defultSpace),
              child: Column(
                children: [
                  //promo slider
                  const TpromoSlider(banners: [
                    TImages.promoBanner1,
                    TImages.promoBanner2,
                    TImages.promoBanner3,
                    TImages.promoBanner4,
                  ]),
                  const SizedBox(height: TSizes.spaceBtwScetions),

                  //heading
                  TSectionHeading(
                      title: 'Popular Products',
                      onPressed: () => Get.to(() => const AllProdcutScreen())),
                  const SizedBox(height: TSizes.spaceBtwItems),

                  //popular product
                  TGridLayout(
                    mainAxisExtent: 288,
                    itemCount: 4,
                    itemBuilder: (context, index) =>
                        const TProductCartVertical(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
