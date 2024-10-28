import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store/common/widgets/appbar/custom_appbar.dart';
import 'package:t_store/common/widgets/custom_shapes/curvied_shapes/curvied_edges_widgets.dart';
import 'package:t_store/common/widgets/icons/circular_icons.dart';
import 'package:t_store/common/widgets/images/t_rounded_images.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/constants/image_strings.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/helpers/helper_function.dart';

class TProdutImageSIider extends StatelessWidget {
  const TProdutImageSIider({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunction.isDarkMode(context);
    return TCurvedEdgeWdget(
      child: Container(
        color: isDark ? TColors.darkerGrey : TColors.light,
        child: Stack(
          children: [
            SizedBox(
                height: 400,
                child: Padding(
                  padding: const EdgeInsets.all(TSizes.productImageRadius * 2),
                  child: Center(child: Image.asset(TImages.productImage4)),
                )),

            ///...Image Slider
            Positioned(
              right: 0,
              bottom: 30,
              left: TSizes.defultSpace,
              child: SizedBox(
                height: 80,
                child: ListView.separated(
                  shrinkWrap: true,
                  padding: const EdgeInsets.only(right: TSizes.defultSpace),
                  scrollDirection: Axis.horizontal,
                  separatorBuilder: (context, index) =>
                      const SizedBox(width: TSizes.spaceBtwItems),
                  itemCount: 8,
                  itemBuilder: (context, index) => TRoundedlmages(
                    imageUrl: TImages.productImage2,
                    width: 80,
                    backgroundColor: isDark ? TColors.dark : TColors.white,
                    border: Border.all(color: TColors.primary),
                    padding: const EdgeInsets.all(TSizes.sm),
                  ),
                ),
              ),
            ),

            ///...Appbar Iocons
            const TAppbar(
              showBackArrow: true,
              actions: [TcircularIcon(icon: Iconsax.heart5, color: Colors.red)],
            ),
          ],
        ),
      ),
    );
  }
}
