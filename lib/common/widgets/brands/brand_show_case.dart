import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_store/common/widgets/custom_shapes/container/rounded_container.dart';
import 'package:t_store/common/widgets/brands/brand_cards.dart';
import 'package:t_store/common/widgets/loading/skeltionizer.dart';
import 'package:t_store/features/shop/models/brand_model.module.dart';
import 'package:t_store/features/shop/screens/barnds/brands_product.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/helpers/helper_function.dart';

class TBrandShowCase extends StatelessWidget {
  const TBrandShowCase({
    super.key,
    required this.images,
    required this.brand,
  });

  final BrandModel brand;
  final List<String> images;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Get.to(() => BrandsProductScreen(brand: brand)),
      child: TRoundedContainer(
        showBorder: true,
        borderCoIor: TColors.darkGrey,
        backgroundCoIor: Colors.transparent,
        margin: const EdgeInsets.only(bottom: TSizes.spaceBtwItems),
        padding: const EdgeInsets.all(TSizes.md),
        child: Column(
          children: [
            //..Brand Product Count
            TBrandCard(showBoder: false, brand: brand),
            const SizedBox(height: TSizes.spaceBtwItems),

            //..Brand top 3 product image
            Row(
                children: images
                    .map((image) => brandTopProductImageNidqet(image, context))
                    .toList())
          ],
        ),
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
      child: CachedNetworkImage(
        imageUrl: image,
        fit: BoxFit.contain,
        progressIndicatorBuilder: (context, url, progress) =>
            const TShammerEffect(width: 100, height: 100),
        errorWidget: (context, url, error) => const Icon(Icons.error),
      ),
    ),
  );
}
