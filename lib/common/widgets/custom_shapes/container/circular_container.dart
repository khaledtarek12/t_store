import 'package:flutter/material.dart';
import 'package:t_store/utils/constants/colors.dart';

class TCircularContainer extends StatelessWidget {
  const TCircularContainer({
    super.key,
    this.width = 400,
    this.height = 400,
    this.radius = 400,
    this.padding = 0,
    this.margin,
    this.child,
    this.backgroundCoIor = TColors.textWhite,
    this.duration = Duration.zero,
    this.curve = Curves.easeInOut,
  });

  final double? width;
  final double? height;
  final double radius;
  final double padding;
  final EdgeInsetsGeometry? margin;
  final Widget? child;
  final Color backgroundCoIor;
  final Duration duration;
  final Curve curve;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: duration,
      curve: curve,
      width: width,
      height: height,
      margin: margin,
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius), color: backgroundCoIor),
      child: child,
    );
  }
}
