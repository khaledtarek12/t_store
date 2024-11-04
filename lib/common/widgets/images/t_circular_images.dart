import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:t_store/common/widgets/loading/skeltionizer.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/helpers/helper_function.dart';

class TCircularImage extends StatelessWidget {
  const TCircularImage({
    super.key,
    this.width = 56,
    this.height = 56,
    required this.image,
    this.backgroundColor,
    this.overLayColor,
    this.fit = BoxFit.cover,
    this.isNetworkImage = false,
  });

  final double width, height;
  final String image;
  final Color? backgroundColor;
  final Color? overLayColor;
  final BoxFit fit;
  final bool isNetworkImage;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: backgroundColor ??
            (THelperFunction.isDarkMode(context)
                ? TColors.black
                : TColors.white),
        shape: BoxShape.circle,
      ),
      child: ClipOval(
        child: isNetworkImage
            ? CachedNetworkImage(
                imageUrl: image,
                fit: BoxFit.cover,
                color: overLayColor,
                errorWidget: (context, url, error) => const Icon(Icons.error),
                progressIndicatorBuilder: (context, url, progress) =>
                    const TSkeletonEffect(width: 55, height: 55, radius: 55),
              )
            : Image.asset(
                image,
                fit: BoxFit.cover,
                color: overLayColor,
              ),
      ),
    );
  }
}
