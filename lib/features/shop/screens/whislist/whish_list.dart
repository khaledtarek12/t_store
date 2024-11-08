import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:t_store/common/layouts/grid_layout.dart';
import 'package:t_store/common/widgets/appbar/custom_appbar.dart';
import 'package:t_store/common/widgets/icons/circular_icons.dart';
import 'package:t_store/common/widgets/products/product_cards/product_cart_virtical.dart';
import 'package:t_store/features/shop/controllers/product_controller.dart';
import 'package:t_store/features/shop/screens/home/home.dart';
import 'package:t_store/utils/constants/sizes.dart';

class WhishListScreen extends StatelessWidget {
  const WhishListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = ProductController.instance;
    return Scaffold(
      appBar: TAppbar(
          title: Text('Whislist',
              style: Theme.of(context).textTheme.headlineMedium),
          actions: [
            TcircularIcon(
                icon: Iconsax.add,
                onPressed: () => Get.to(() => const HomeScreen()))
          ]),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defultSpace),
          child: Column(
            children: [
              Obx(() {
                if (controller.featuredProducts.isEmpty) {
                  return Center(
                      child: Text('No Data Found!',
                          style: Theme.of(context).textTheme.bodyMedium));
                }
                return Skeletonizer(
                  enabled: controller.loading.value,
                  child: TGridLayout(
                    itemCount: controller.featuredProducts.length,
                    itemBuilder: (context, index) => TProductCartVertical(
                      product: controller.featuredProducts[index],
                    ),
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
