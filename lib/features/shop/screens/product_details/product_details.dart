import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:readmore/readmore.dart';
import 'package:t_store/common/widgets/texts/seaction_heading.dart';
import 'package:t_store/features/shop/screens/product_details/widgets/bottom_add_to_cart_wigdet.dart';
import 'package:t_store/features/shop/screens/product_details/widgets/product_attributes.dart';
import 'package:t_store/features/shop/screens/product_details/widgets/product_datails_image_slider.dart';
import 'package:t_store/features/shop/screens/product_details/widgets/product_meta_data.dart';
import 'package:t_store/features/shop/screens/product_details/widgets/rating_share_widget.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/helpers/helper_function.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const TBottomAddToCart(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ///... product iamge slider
            const TProdutImageSIider(),

            ///...product Details
            Padding(
              padding: const EdgeInsets.only(
                left: TSizes.defultSpace,
                right: TSizes.defultSpace,
                bottom: TSizes.defultSpace,
              ),
              child: Column(
                children: [
                  //..Rating & share
                  const TRatingAndShare(),

                  //..Price, Titte, Stock, & Brand
                  const TProductMetaData(),

                  //..Attrabutes
                  const TProductAttributes(),
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
                  const ReadMoreText(
                    'This is a Product description for Blue Nike Sleeve less vest. There are more things that can be added but i am just practicing and nothing else. ',
                    trimLength: 2,
                    trimMode: TrimMode.Line,
                    trimCollapsedText: '  Show more',
                    trimExpandedText: '   Show Less',
                    moreStyle:
                        TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
                    lessStyle:
                        TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
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
                          onPressed: () {},
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
