import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_store/common/layouts/grid_layout.dart';
import 'package:t_store/common/shammer/category_shammer.dart';
import 'package:t_store/common/widgets/products/product_cards/product_cart_virtical.dart';
import 'package:t_store/common/widgets/texts/seaction_heading.dart';
import 'package:t_store/features/shop/controllers/category_controller.dart';
import 'package:t_store/features/shop/models/category_model.module.dart';
import 'package:t_store/features/shop/screens/all_product/all_prodcut.dart';
import 'package:t_store/features/shop/screens/store/widgets/category_brand.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/helpers/cloud_helper_function.dart';

class TCategoryTab extends StatelessWidget {
  const TCategoryTab({
    super.key,
    required this.category,
  });

  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    final categoryController = CategoryController.instance;
    return ListView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          Padding(
            padding: const EdgeInsets.all(TSizes.defultSpace),
            child: Column(
              children: [
                //...Brands
                CategoryBrands(category: category),
                const SizedBox(height: TSizes.spaceBtwItems),

                //...Products
                FutureBuilder(
                    future: categoryController.getCategoryProducts(
                        categoryId: category.id),
                    builder: (context, snapshot) {
                      final widget = TCloudHelperFunction.checkMultiRecordState(
                          snapshot: snapshot,
                          loader: const TVerticalProductShimmer());
                      if (widget != null) return widget;

                      final products = snapshot.data!;

                      return Column(
                        children: [
                          TSectionHeading(
                            title: 'You might like',
                            onPressed: () => Get.to(
                              () => AllProdcutScreen(
                                title: category.name,
                                futureMethod:
                                    categoryController.getCategoryProducts(
                                  categoryId: category.id,
                                  limit: -1,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: TSizes.spaceBtwItems),
                          TGridLayout(
                            itemCount: products.length,
                            itemBuilder: (context, index) {
                              log(products.length.toString());

                              return TProductCartVertical(
                                product: products[index],
                              );
                            },
                          )
                        ],
                      );
                    }),
              ],
            ),
          ),
        ]);
  }
}
