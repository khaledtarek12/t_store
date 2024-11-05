import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/helpers/helper_function.dart';

class TSkeletonEffect extends StatelessWidget {
  const TSkeletonEffect({
    super.key,
    required this.width,
    required this.height,
    this.radius = 50,
    this.color,
  });

  final double width, height, radius;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunction.isDarkMode(context);

    return Skeletonizer(
      enabled: true, // Ensures skeleton effect is active
      effect: ShimmerEffect(
        baseColor: dark ? Colors.grey[850]! : Colors.grey[300]!,
        highlightColor: dark ? Colors.grey[700]! : Colors.grey[100]!,
      ),
      enableSwitchAnimation: true,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: color ?? (dark ? TColors.darkerGrey : TColors.white),
          borderRadius: BorderRadius.circular(radius),
        ),
      ),
    );
  }
}
