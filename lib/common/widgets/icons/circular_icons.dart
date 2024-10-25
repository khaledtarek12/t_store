import 'package:flutter/material.dart';
import 'package:t_store/utils/constants/sizes.dart';

class TcircularIcon extends StatelessWidget {
  const TcircularIcon(
      {super.key,
      this.width,
      this.height,
      this.size = TSizes.lg,
      required this.icon,
      this.color,
      this.backgroundColor,
      this.onPressed});

  final double? width, height, size;
  final IconData icon;
  final Color? color;
  final Color? backgroundColor;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    // final dark = THelperFunction.isDarkMode(context);
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        // color: backgroundColor != null
        //     ? backgroundColor!
        //     : dark
        //         ? TColors.balck.withOpacity(0.9)
        //         : TColors.white.withOpacity(0.9),
      ),
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(
          icon,
          color: color,
          size: size,
        ),
      ),
    );
  }
}
