import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:readmore/readmore.dart';
import 'package:t_store/common/widgets/texts/seaction_heading.dart';
import 'package:t_store/features/shop/models/product_model.module.dart';
import 'package:t_store/features/shop/screens/product_details/widgets/bottom_add_to_cart_wigdet.dart';
import 'package:t_store/features/shop/screens/product_details/widgets/product_attributes.dart';
import 'package:t_store/features/shop/screens/product_details/widgets/product_datails_image_slider.dart';
import 'package:t_store/features/shop/screens/product_details/widgets/product_meta_data.dart';
import 'package:t_store/features/shop/screens/product_details/widgets/rating_share_widget.dart';
import 'package:t_store/features/shop/screens/product_reviews/product_reviews.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/constants/enums.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/helpers/helper_function.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar:  TBottomAddToCart(product: product),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ///... product iamge slider
            TProdutImageSIider(products: product),

            ///...product Details
            Padding(
              padding: const EdgeInsets.only(
                left: TSizes.defultSpace,
                right: TSizes.defultSpace,
                bottom: TSizes.defultSpace,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //..Rating & share
                  const TRatingAndShare(),

                  //..Price, Titte, Stock, & Brand
                  TProductMetaData(product: product),
                  const SizedBox(height: TSizes.spaceBtwItems / 2),

                  //..Attrabutes
                  if (product.productType == ProductType.variable.toString())
                    TProductAttributes(product: product),
                  if (product.productType == ProductType.variable.toString())
                    const SizedBox(height: TSizes.spaceBtwScetions),

                  //..Checkout Buttons
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        onPressed: () {}, child: const Text('CheckOut')),
                  ),
                  const SizedBox(height: TSizes.spaceBtwScetions),

                  //..Descriptions
                  const TSectionHeading(
                      title: 'Description', showActionButton: false),
                  const SizedBox(height: TSizes.spaceBtwItems),
                  ReadMoreText(
                    product.description ?? '',
                    trimLength: 2,
                    trimMode: TrimMode.Line,
                    trimCollapsedText: '  Show more',
                    trimExpandedText: '   Show Less',
                    moreStyle: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.w800),
                    lessStyle: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.w800),
                  ),
                  const SizedBox(height: TSizes.spaceBtwItems),

                  //..Reviews
                  const Divider(),
                  const SizedBox(height: TSizes.spaceBtwItems),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const TSectionHeading(
                          title: 'Reviews(199)', showActionButton: false),
                      IconButton(
                          onPressed: () =>
                              Get.to(() => const ProductReviewsScreen()),
                          icon: Icon(
                            Iconsax.arrow_right_3,
                            size: 18,
                            color: THelperFunction.isDarkMode(context)
                                ? TColors.white
                                : TColors.black,
                          ))
                    ],
                  ),
                  const SizedBox(height: TSizes.spaceBtwScetions),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
