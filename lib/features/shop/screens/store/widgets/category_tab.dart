import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:t_store/common/layouts/grid_layout.dart';
import 'package:t_store/common/widgets/brands/brand_show_case.dart';
import 'package:t_store/common/widgets/products/product_cards/product_cart_virtical.dart';
import 'package:t_store/common/widgets/texts/seaction_heading.dart';
import 'package:t_store/features/shop/controllers/product_controller.dart';
import 'package:t_store/features/shop/models/category_model.module.dart';
import 'package:t_store/features/shop/models/product_model.module.dart';
import 'package:t_store/utils/constants/image_strings.dart';
import 'package:t_store/utils/constants/sizes.dart';

class TCategoryTab extends StatelessWidget {
  const TCategoryTab({
    super.key,
    required this.category,
  });

  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    final controller = ProductController.instance;
    return ListView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          Padding(
            padding: const EdgeInsets.all(TSizes.defultSpace),
            child: Column(
              children: [
                //...Brands
                const TBrandShowcase(
                  images: [
                    TImages.productImage3,
                    TImages.productImage2,
                    TImages.productImage1,
                  ],
                ),
                const TBrandShowcase(
                  images: [
                    TImages.productImage3,
                    TImages.productImage2,
                    TImages.productImage1,
                  ],
                ),
                const SizedBox(height: TSizes.spaceBtwItems),

                //...Products
                TSectionHeading(title: 'You might like', onPressed: () {}),
                const SizedBox(height: TSizes.spaceBtwItems),

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
        ]);
  }
}
