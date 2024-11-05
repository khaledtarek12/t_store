import 'package:flutter/material.dart';
import 'package:t_store/common/widgets/images/t_circular_images.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/helpers/helper_function.dart';

class TVerticallmageText extends StatelessWidget {
  const TVerticallmageText({
    super.key,
    required this.image,
    required this.title,
    this.textColor = TColors.white,
    this.backGroundColor = TColors.white,
    this.onTap,
    this.isNetworkImage = true,
  });

  final String image, title;
  final Color textColor;
  final Color? backGroundColor;
  final bool isNetworkImage;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunction.isDarkMode(context);

    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(right: TSizes.spaceBtwItems),
        child: Column(
          children: [
            //Icons
            TCircularImage(
              image: image,
              fit: BoxFit.fitWidth,
              padding: TSizes.sm * 1.4,
              isNetworkImage: isNetworkImage,
              backgroundColor: backGroundColor,
              overLayColor: dark ? TColors.light : TColors.dark,
            ),

            const SizedBox(height: TSizes.spaceBtwItems / 2),
            //Texts
            SizedBox(
              width: 55,
              child: Text(
                textAlign: TextAlign.center,
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context)
                    .textTheme
                    .labelMedium!
                    .apply(color: textColor),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
