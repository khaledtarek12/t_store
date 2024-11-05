import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:t_store/common/widgets/image_text_widget/vertical_image_text.dart';
import 'package:t_store/common/widgets/texts/seaction_heading.dart';
import 'package:t_store/features/shop/controllers/category_controller.dart';
import 'package:t_store/features/shop/screens/sub_categories/sub_categories.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/helpers/helper_function.dart';

class THomeCategroy extends StatelessWidget {
  const THomeCategroy({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunction.isDarkMode(context);
    final controller = Get.put(CategoryController());
    return Padding(
      padding: const EdgeInsets.only(left: TSizes.defultSpace),
      child: Column(
        children: [
          //heading
          const TSectionHeading(
            title: 'Popular Categories',
            showActionButton: false,
            textColor: TColors.white,
          ),
          const SizedBox(height: TSizes.spaceBtwItems),
          //Categories
          Obx(() {
            if (controller.featuredCateogries.isEmpty) {
              return Center(
                child: Text(
                  'No Data Found!',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .apply(color: Colors.white),
                ),
              );
            } else {
              return Skeletonizer(
                enabled: controller.isLoading.value,
                child: SizedBox(
                  height: 80,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: controller.featuredCateogries.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      final category = controller.featuredCateogries[index];
                      return TVerticallmageText(
                        image: category.image,
                        title: category.name,
                        backGroundColor: (dark ? TColors.dark : TColors.white),
                        onTap: () => Get.to(() => const SubCategoriesScreen()),
                      );
                    },
                  ),
                ),
              );
            }
          }),
        ],
      ),
    );
  }
}
