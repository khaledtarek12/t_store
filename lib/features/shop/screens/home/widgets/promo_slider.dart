import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:page_view_dot_indicator/page_view_dot_indicator.dart';
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
          items: banners.map((url) => TRoundedlmages(imageUrl: url)).toList(),
        ),
        const SizedBox(height: TSizes.spaceBtwItems),
        Obx(() {
          return PageViewDotIndicator(
            currentItem: controller.carsoualCurrentIndex.value,
            count: banners.length,
            unselectedColor: TColors.grey,
            selectedColor: TColors.primary,
            duration: const Duration(milliseconds: 300),
            boxShape: BoxShape.circle,
            size: const Size(20, 15),
            unselectedSize: const Size(10, 5),
            margin: const EdgeInsets.symmetric(horizontal: 5),
          );
        }),
      ],
    );
  }
}
