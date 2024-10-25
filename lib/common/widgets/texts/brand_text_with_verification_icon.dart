import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store/common/widgets/texts/brand_title_text.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/constants/enums.dart';
import 'package:t_store/utils/constants/sizes.dart';

class TBrandTit1ewithVerifiedIcon extends StatelessWidget {
  const TBrandTit1ewithVerifiedIcon({
    super.key,
    required this.title,
    this.maxLines = 1,
    this.textColor,
    this.iconColor = TColors.primary,
    this.textAlign = TextAlign.center,
    this.brandTextSized = TextSizes.small,
  });

  final String title;
  final int maxLines;
  final Color? textColor, iconColor;
  final TextAlign? textAlign;
  final TextSizes brandTextSized;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
          child: TBrandTitleText(
            title: title,
            textAlign: textAlign,
            color: textColor,
            maxLines: maxLines,
            brandTextSized: brandTextSized,
          ),
        ),
        const SizedBox(width: TSizes.xs),
        Icon(Iconsax.verify5, color: iconColor, size: TSizes.iconsXs),
      ],
    );
  }
}
