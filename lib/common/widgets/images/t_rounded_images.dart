import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:t_store/common/widgets/loading/skeltionizer.dart';
import 'package:t_store/utils/constants/sizes.dart';

class TRoundedlmages extends StatelessWidget {
  const TRoundedlmages({
    super.key,
    this.borderRaduis = TSizes.md,
    this.onPressed,
    this.padding,
    this.border,
    this.width,
    this.hight,
    required this.imageUrl,
    this.fit = BoxFit.contain,
    this.isNetworkImage = false,
    this.applayImageRaduis = true,
    this.backgroundColor,
  });

  final double? width, hight;
  final String imageUrl;
  final bool applayImageRaduis;
  final BoxBorder? border;
  final Color? backgroundColor;
  final BoxFit fit;
  final EdgeInsetsGeometry? padding;
  final bool isNetworkImage;
  final VoidCallback? onPressed;
  final double borderRaduis;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: width,
        height: hight,
        padding: padding,
        decoration: BoxDecoration(
          border: border,
          color: backgroundColor,
          borderRadius: BorderRadius.circular(borderRaduis),
        ),
        child: ClipRRect(
          borderRadius: applayImageRaduis
              ? BorderRadius.circular(borderRaduis)
              : BorderRadius.zero,
          child: isNetworkImage
              ? CachedNetworkImage(
                  imageUrl: imageUrl,
                  fit: BoxFit.contain,
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                  progressIndicatorBuilder: (context, url, progress) =>
                      TSkeletonEffect(
                    width: double.infinity, // Use specified width or default
                    height: 190, // Use specified height or default
                    radius: borderRaduis,
                  ),
                )
              : Image.asset(imageUrl, fit: fit),
        ),
      ),
    );
  }
}
