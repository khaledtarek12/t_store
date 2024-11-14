import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_store/common/shammer/sub_category_shammer.dart';
import 'package:t_store/common/widgets/appbar/custom_appbar.dart';
import 'package:t_store/common/widgets/images/t_rounded_images.dart';
import 'package:t_store/common/widgets/products/product_cards/product_cart_horizontal.dart';
import 'package:t_store/common/widgets/texts/seaction_heading.dart';
import 'package:t_store/features/shop/controllers/category_controller.dart';
import 'package:t_store/features/shop/models/category_model.module.dart';
import 'package:t_store/features/shop/screens/all_product/all_prodcut.dart';
import 'package:t_store/utils/constants/image_strings.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/helpers/cloud_helper_function.dart';

class SubCategoriesScreen extends StatelessWidget {
  const SubCategoriesScreen({super.key, required this.category});

  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    final controller = CategoryController.instance;
    return Scaffold(
      appBar: TAppbar(
          showBackArrow: true,
          title: Text(category.name,
              style: Theme.of(context).textTheme.headlineSmall)),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defultSpace),
          child: Column(
            children: [
              //..Banar
              const TRoundedlmages(
                imageUrl: TImages.promoBanner4,
                width: double.infinity,
                applayImageRaduis: true,
              ),
              const SizedBox(height: TSizes.spaceBtwScetions),

              //..Sub categories
              FutureBuilder(
                  future: controller.getSubCategory(categoryId: category.id),
                  builder: (context, snapshot) {
                    final loader = THorzinalProductShammer();
                    final widget = TCloudHelperFunction.checkMultiRecordState(
                      snapshot: snapshot,
                      loader: loader,
                    );

                    if (widget != null) return widget;

                    final subCategories = snapshot.data;

                    return ListView.builder(
                        shrinkWrap: true,
                        itemCount: subCategories?.length ?? 0,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          final subCategory = subCategories![index];

                          return FutureBuilder(
                              future: controller.getCategoryProducts(
                                  categoryId: subCategory.id),
                              builder: (context, snapshot) {
                                final widget =
                                    TCloudHelperFunction.checkMultiRecordState(
                                  snapshot: snapshot,
                                  loader: loader,
                                );

                                if (widget != null) return widget;

                                final products = snapshot.data!;

                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    TSectionHeading(
                                      title: subCategory.name,
                                      onPressed: () => Get.to(
                                        () => AllProdcutScreen(
                                          title: subCategory.name,
                                          futureMethod:
                                              controller.getCategoryProducts(
                                                  categoryId: subCategory.id,
                                                  limit: -1),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                        height: TSizes.spaceBtwItems / 2),
                                    SizedBox(
                                      height: 120,
                                      child: ListView.separated(
                                        shrinkWrap: true,
                                        itemCount: products.length,
                                        scrollDirection: Axis.horizontal,
                                        separatorBuilder: (context, index) =>
                                            const SizedBox(
                                                width: TSizes.spaceBtwItems),
                                        itemBuilder: (context, index) =>
                                            TProductCartHorizontal(
                                                product: products[index]),
                                      ),
                                    ),
                                    const SizedBox(
                                        height: TSizes.spaceBtwScetions),
                                  ],
                                );
                              });
                        });
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
