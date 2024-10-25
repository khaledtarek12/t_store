import 'package:flutter/material.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/helpers/helper_function.dart';

class TCircularImage extends StatelessWidget {
  const TCircularImage({
    super.key,
    this.width = 56,
    this.hight = 56,
    this.padding = TSizes.sm,
    required this.image,
    this.backgroundColor,
    this.overLayColor,
    this.fit = BoxFit.cover,
    this.isNetworkImage = false,
  });

  final double width, hight, padding;
  final String image;
  final Color? backgroundColor;
  final Color? overLayColor;
  final BoxFit fit;
  final bool isNetworkImage;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: hight,
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
          color: backgroundColor ??
              (THelperFunction.isDarkMode(context)
                  ? TColors.balck
                  : TColors.white),
          borderRadius: BorderRadius.circular(100)),
      child: isNetworkImage
          ? Image.network(fit: fit, image, color: overLayColor)
          : Image.asset(fit: fit, image, color: overLayColor),
    );
  }
}
