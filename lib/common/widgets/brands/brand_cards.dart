import 'package:flutter/material.dart';
import 'package:t_store/common/widgets/custom_shapes/container/rounded_container.dart';
import 'package:t_store/common/widgets/images/t_circular_images.dart';
import 'package:t_store/common/widgets/texts/brand_text_with_verification_icon.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/constants/enums.dart';
import 'package:t_store/utils/constants/image_strings.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/helpers/helper_function.dart';

class TBrandCard extends StatelessWidget {
  const TBrandCard({
    super.key, required this.showBoder,  this.onTap,
  });

  final bool showBoder;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunction.isDarkMode(context);
    return InkWell(
      borderRadius: BorderRadius.circular(TSizes.cardRadiusLg),
      onTap: onTap,
      child: TRoundedContainer(
        padding: const EdgeInsets.all(TSizes.sm),
        showBorder: showBoder,
        backgroundCoIor: Colors.transparent,
        child: Row(
          children: [
            //// Iocn
            Flexible(
              child: TCircularImage(
                  image: TImages.clothIcon,
                  backgroundColor: Colors.transparent,
                  overLayColor: isDark ? TColors.white : TColors.black),
            ),
            const SizedBox(width: TSizes.spaceBtwItems / 2),
            //// Text
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const TBrandTit1ewithVerifiedIcon(
                    title: 'Nike',
                    brandTextSized: TextSizes.large,
                  ),
                  Text(
                    '256 Product',
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.labelMedium,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
