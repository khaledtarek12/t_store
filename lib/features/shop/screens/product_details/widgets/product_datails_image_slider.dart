import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store/common/widgets/appbar/custom_appbar.dart';
import 'package:t_store/common/widgets/custom_shapes/curvied_shapes/curvied_edges_widgets.dart';
import 'package:t_store/common/widgets/icons/circular_icons.dart';
import 'package:t_store/common/widgets/images/t_rounded_images.dart';
import 'package:t_store/common/widgets/loading/custom_loading.dart';
import 'package:t_store/features/shop/controllers/products/image_controller.dart';
import 'package:t_store/features/shop/models/product_model.module.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/helpers/helper_function.dart';

class TProdutImageSIider extends StatelessWidget {
  const TProdutImageSIider({super.key, required this.products});

  final ProductModel products;

  @override
  Widget build(BuildContext context) {
    final imageController = Get.put(ImageController());
    final images = imageController.getAllProductImages(products);
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
                child: Center(
                  child: Obx(
                    () {
                      final image = imageController.selectedProductImage.value;
                      return InkWell(
                        onTap: () =>
                            imageController.showLargeImage(context, image),
                        child: CachedNetworkImage(
                          imageUrl: image,
                          progressIndicatorBuilder: (context, url, progress) =>
                              const CustomLoading(
                                  loadingColor: TColors.primary),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),

            ///...Image Slider
            Positioned(
              right: 0,
              bottom: 30,
              left: TSizes.defultSpace,
              child: SizedBox(
                height: 80,
                child: ListView.separated(
                  itemCount: images.length,
                  shrinkWrap: true,
                  padding: const EdgeInsets.only(right: TSizes.defultSpace),
                  scrollDirection: Axis.horizontal,
                  separatorBuilder: (context, index) =>
                      const SizedBox(width: TSizes.spaceBtwItems),
                  itemBuilder: (context, index) => Obx(() {
                    final imageSelected =
                        imageController.selectedProductImage.value ==
                            images[index];
                    return TRoundedlmages(
                      imageUrl: images[index],
                      width: 80,
                      isNetworkImage: true,
                      backgroundColor: isDark ? TColors.dark : TColors.white,
                      onPressed: () => imageController
                          .selectedProductImage.value = images[index],
                      border: Border.all(
                          width: 3,
                          color: imageSelected
                              ? TColors.primary
                              : Colors.transparent),
                      padding: const EdgeInsets.all(TSizes.sm),
                    );
                  }),
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
