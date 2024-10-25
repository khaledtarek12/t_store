import 'package:flutter/material.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/constants/sizes.dart';

class TRoundedContainer extends StatelessWidget {
  const TRoundedContainer({
    super.key,
    this.width,
    this.height,
    this.radius = TSizes.cardRadiusLg,
    this.padding,
    this.margin,
    this.child,
    this.backgroundCoIor = TColors.white,
    this.showBorder = false,
    this.borderCoIor = TColors.borderPrimary,
  });

  final double? width;
  final double? height;
  final double radius;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Widget? child;
  final bool showBorder;
  final Color backgroundCoIor;
  final Color borderCoIor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: margin,
      padding: padding,
      decoration: BoxDecoration(
        border: showBorder ? Border.all(color: borderCoIor) : null,
        borderRadius: BorderRadius.circular(radius),
        color: backgroundCoIor,
      ),
      child: child,
    );
  }
}
