import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_store/common/widgets/custom_shapes/container/circular_container.dart';
import 'package:t_store/common/widgets/images/t_rounded_images.dart';
import 'package:t_store/features/shop/controllers/home_controller.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/constants/sizes.dart';

class TpromoSlider extends StatelessWidget {
  const TpromoSlider({
    super.key,
    required this.banners,
  });

  final List banners;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());
    return Column(
      children: [
        CarouselSlider(
            options: CarouselOptions(
              viewportFraction: 1,
              onPageChanged: (index, reason) {
                controller.updatePageIndicator(index);
              },
            ),
            items:
                banners.map((url) => TRoundedlmages(imageUrl: url)).toList()),
        const SizedBox(height: TSizes.spaceBtwItems),
        Obx(() {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (int i = 0; i < banners.length; i++)
                TCircularContainer(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.decelerate,
                  margin: const EdgeInsets.only(right: 10),
                  width: controller.carsoualCurrentIndex.value == i ? 30 : 15,
                  height: 5,
                  backgroundCoIor: controller.carsoualCurrentIndex.value == i
                      ? TColors.primary
                      : TColors.grey,
                ),
            ],
          );
        }),
      ],
    );
  }
}
