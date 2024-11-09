import 'package:flutter/material.dart';
import 'package:t_store/common/widgets/custom_shapes/container/rounded_container.dart';
import 'package:t_store/common/widgets/brands/brand_cards.dart';
import 'package:t_store/features/shop/models/brand_model.module.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/helpers/helper_function.dart';

class TBrandShowCase extends StatelessWidget {
  const TBrandShowCase({
    super.key,
    required this.images,
  });

  final List<String> images;

  @override
  Widget build(BuildContext context) {
    return TRoundedContainer(
      showBorder: true,
      borderCoIor: TColors.darkGrey,
      backgroundCoIor: Colors.transparent,
      margin: const EdgeInsets.only(bottom: TSizes.spaceBtwItems),
      padding: const EdgeInsets.all(TSizes.md),
      child: Column(
        children: [
          //..Brand Product Count
          TBrandCard(showBoder: false, brand: BrandModel.empty()),
          const SizedBox(height: TSizes.spaceBtwItems),

          //..Brand top 3 product image
          Row(
              children: images
                  .map((image) => brandTopProductImageNidqet(image, context))
                  .toList())
        ],
      ),
    );
  }
}

Widget brandTopProductImageNidqet(String image, BuildContext context) {
  return Expanded(
    child: TRoundedContainer(
      height: 100,
      backgroundCoIor: THelperFunction.isDarkMode(context)
          ? TColors.darkerGrey
          : TColors.light,
      margin: const EdgeInsets.only(right: TSizes.sm),
      padding: const EdgeInsets.only(right: TSizes.sm),
      child: Image.asset(image, fit: BoxFit.contain),
    ),
  );
}
