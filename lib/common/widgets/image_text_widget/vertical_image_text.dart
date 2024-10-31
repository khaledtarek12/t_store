import 'package:flutter/material.dart';
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
  });

  final String image, title;
  final Color textColor;
  final Color? backGroundColor;
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
            Container(
              width: 56,
              height: 56,
              padding: const EdgeInsets.all(TSizes.sm),
              decoration: BoxDecoration(
                  color: backGroundColor,
                  borderRadius: BorderRadius.circular(100)),
              child: Center(
                child: Image.asset(image,
                    fit: BoxFit.cover,
                    color: dark ? TColors.light : TColors.dark),
              ),
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
