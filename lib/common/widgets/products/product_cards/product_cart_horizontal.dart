import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store/common/styles/shadows.dart';
import 'package:t_store/common/widgets/custom_shapes/container/rounded_container.dart';
import 'package:t_store/common/widgets/icons/circular_icons.dart';
import 'package:t_store/common/widgets/images/t_rounded_images.dart';
import 'package:t_store/common/widgets/texts/brand_text_with_verification_icon.dart';
import 'package:t_store/common/widgets/texts/product_price_text.dart';
import 'package:t_store/common/widgets/texts/product_title_text.dart';
import 'package:t_store/features/shop/screens/product_details/product_details.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/constants/image_strings.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/helpers/helper_function.dart';

class TProductCartHorizontal extends StatelessWidget {
  const TProductCartHorizontal({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunction.isDarkMode(context);
    return GestureDetector(
      onTap: () => Get.to(() => const ProductDetailsScreen()),
      child: Container(
        width: 310,
        padding: const EdgeInsets.all(1),
        decoration: BoxDecoration(
          boxShadow: [
            dark ? const BoxShadow() : TShadowsStyle.verticalProductShadow
          ],
          borderRadius: BorderRadius.circular(TSizes.productImageRadius),
          color: dark ? TColors.darkerGrey : TColors.white,
        ),
        child: Row(
          children: [
            //thumbnail , Wishlist Button , DIscountTag
            TRoundedContainer(
              height: 120,
              padding: const EdgeInsets.all(TSizes.sm),
              backgroundCoIor: dark ? TColors.dark : TColors.light,
              child: Stack(
                children: [
                  //Image
                  const SizedBox(
                    width: 120,
                    height: 120,
                    child: TRoundedlmages(
                        imageUrl: TImages.productImage1,
                        applayImageRaduis: true),
                  ),
                  //sales
                  Positioned(
                    top: 12,
                    child: TRoundedContainer(
                        radius: TSizes.sm,
                        backgroundCoIor: TColors.secondey.withOpacity(0.8),
                        padding: const EdgeInsets.symmetric(
                            horizontal: TSizes.sm, vertical: TSizes.xs),
                        child: Text('25%',
                            style: Theme.of(context)
                                .textTheme
                                .labelLarge!
                                .apply(color: TColors.black))),
                  ),

                  //favorite icon button
                  Positioned(
                    right: 0,
                    top: 0,
                    child: TcircularIcon(
                      icon: Iconsax.heart5,
                      color: Colors.red,
                      onPressed: () {},
                    ),
                  )
                ],
              ),
            ),
            // const SizedBox(height: TSizes.spaceBtwItems / 2),

            //Details
            SizedBox(
              width: 172,
              child: Padding(
                padding: const EdgeInsets.only(top: TSizes.sm, left: TSizes.sm),
                child: Column(
                  children: [
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TProductTitleText(
                            text: 'Green Nike Half Sleeves Shirt',
                            smallSize: true),
                        SizedBox(height: TSizes.spaceBtwItems / 2),
                        TBrandTit1ewithVerifiedIcon(title: 'Nike'),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        //price
                        const TProductPriceText(price: '35.0'),

                        const Spacer(),
                        //Add to Cart
                        Container(
                          decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(TSizes.cardRadiusMd),
                                bottomRight:
                                    Radius.circular(TSizes.productImageRadius),
                              ),
                              color: TColors.dark),
                          child: const SizedBox(
                              width: TSizes.iconLg * 1.2,
                              height: TSizes.iconLg * 1.2,
                              child: Center(
                                  child:
                                      Icon(Iconsax.add, color: TColors.white))),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
