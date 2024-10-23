import 'package:flutter/material.dart';
import 'package:t_store/common/widgets/custom_shapes/container/primary_header_container.dart';
import 'package:t_store/common/widgets/custom_shapes/container/search_container.dart';
import 'package:t_store/features/shop/screens/home/widgets/home_appbar.dart';
import 'package:t_store/features/shop/screens/home/widgets/home_categroy.dart';
import 'package:t_store/features/shop/screens/home/widgets/promo_slider.dart';
import 'package:t_store/utils/constants/image_strings.dart';
import 'package:t_store/utils/constants/sizes.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            TPrimaryHeaderContainer(
              chilld: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //App bar
                  THomeAppBar(),
                  SizedBox(height: TSizes.spaceBtwScetions),
                  //Search bar
                  TSearchContainer(text: 'Search in Store'),
                  SizedBox(height: TSizes.spaceBtwScetions),
                  //Categories
                  THomeCategroy()
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(TSizes.defultSpace),
              child: TpromoSlider(
                banners: [
                  TImages.promoBanner1,
                  TImages.promoBanner2,
                  TImages.promoBanner3,
                  TImages.promoBanner4,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
