import 'package:flutter/material.dart';
import 'package:t_store/utils/constants/colors.dart';

class TCircutarContainer extends StatelessWidget {
  const TCircutarContainer({
    super.key,
    this.width = 400,
    this.height = 400,
    this.radius = 400,
    this.padding = 0,
    this.child,
    this.backgroundCoIor = TColors.textWhite,
  });

  final double? width;
  final double? height;
  final double radius;
  final double padding;
  final Widget? child;
  final Color backgroundCoIor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius), color: backgroundCoIor),
      child: child,
    );
  }
}