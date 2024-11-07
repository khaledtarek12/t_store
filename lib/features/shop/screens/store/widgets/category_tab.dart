import 'package:flutter/material.dart';
import 'package:t_store/common/layouts/grid_layout.dart';
import 'package:t_store/common/widgets/brands/brand_show_case.dart';
import 'package:t_store/common/widgets/products/product_cards/product_cart_virtical.dart';
import 'package:t_store/common/widgets/texts/seaction_heading.dart';
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

                TGridLayout(
                  itemCount: 4,
                  itemBuilder: (_, index) {
                    return TProductCartVertical(product: ProductModel.empty());
                  },
                )
              ],
            ),
          ),
        ]);
  }
}
