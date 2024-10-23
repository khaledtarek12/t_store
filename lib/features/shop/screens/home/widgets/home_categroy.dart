import 'package:flutter/material.dart';
import 'package:t_store/common/widgets/image_text_widget/vertical_image_text.dart';
import 'package:t_store/common/widgets/texts/seaction_heading.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/constants/image_strings.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/helpers/helper_function.dart';


class THomeCategroy extends StatelessWidget {
  const THomeCategroy({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunction.isDarkMode(context);

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
          SizedBox(
            height: 80,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: 6,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return TVerticallmageText(
                  image: TImages.bowlingWhite,
                  title: 'bowling',
                  backGroundColor: (dark ? TColors.dark : TColors.white),
                  onTap: () {},
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}