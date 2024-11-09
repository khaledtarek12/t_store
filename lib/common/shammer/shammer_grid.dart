import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store/common/styles/shadows.dart';
import 'package:t_store/common/widgets/custom_shapes/container/rounded_container.dart';
import 'package:t_store/common/widgets/loading/skeltionizer.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/constants/sizes.dart';

class TProductCartVerticalShimmer extends StatelessWidget {
  const TProductCartVerticalShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      width: 180,
      padding: const EdgeInsets.all(1),
      decoration: BoxDecoration(
        boxShadow: [
          dark ? const BoxShadow() : TShadowsStyle.verticalProductShadow
        ],
        borderRadius: BorderRadius.circular(TSizes.productImageRadius),
        color: dark ? TColors.darkerGrey : TColors.white,
      ),
      child: Column(
        children: [
          // Thumbnail, Wishlist Button, Discount Tag Shimmer
          TRoundedContainer(
            height: 180,
            width: 180,
            padding: const EdgeInsets.all(TSizes.sm),
            backgroundCoIor: dark ? TColors.dark : TColors.light,
            child: Stack(
              children: [
                // Image Shimmer
                const Center(
                  child: TShammerEffect(
                    width: 160,
                    height: 160,
                    radius: TSizes.productImageRadius,
                  ),
                ),
                // Sales Tag Shimmer
                Positioned(
                  top: 12,
                  child: TRoundedContainer(
                    radius: TSizes.sm,
                    backgroundCoIor: TColors.secondey.withOpacity(0.8),
                    padding: const EdgeInsets.symmetric(
                      horizontal: TSizes.sm,
                      vertical: TSizes.xs,
                    ),
                    child: const TShammerEffect(
                      width: 30,
                      height: 15,
                    ),
                  ),
                ),
                // Favorite Icon Button Shimmer
                const Positioned(
                  right: 0,
                  top: 0,
                  child: TShammerEffect(
                    width: 32,
                    height: 32,
                    radius: 16,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: TSizes.spaceBtwItems / 2),

          // Details Shimmer
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TShammerEffect(width: 100, height: 15), // Title placeholder
              SizedBox(height: TSizes.spaceBtwItems / 2),
              TShammerEffect(width: 80, height: 15), // Brand name placeholder
            ],
          ),
          const Spacer(),

          // Price and Add Button Row Shimmer
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Price Shimmer
              const Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TShammerEffect(width: 50, height: 15), // Original price
                    SizedBox(height: 4),
                    TShammerEffect(width: 60, height: 18), // Sale price
                  ],
                ),
              ),
              // Add button shimmer
              Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(TSizes.cardRadiusMd),
                    bottomRight: Radius.circular(TSizes.productImageRadius),
                  ),
                  color: TColors.dark,
                ),
                child: const SizedBox(
                  width: TSizes.iconLg * 1.2,
                  height: TSizes.iconLg * 1.2,
                  child: Center(
                    child: Icon(Iconsax.add, color: TColors.white),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
