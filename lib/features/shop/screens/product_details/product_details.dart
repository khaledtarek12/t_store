import 'package:flutter/material.dart';
import 'package:t_store/features/shop/screens/product_details/widgets/product_datails_image_slider.dart';
import 'package:t_store/features/shop/screens/product_details/widgets/product_meta_data.dart';
import 'package:t_store/features/shop/screens/product_details/widgets/rating_share_widget.dart';
import 'package:t_store/utils/constants/sizes.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            ///... product iamge slider
            TProdutImageSIider(),

            ///...product Details
            Padding(
              padding: EdgeInsets.only(
                left: TSizes.defultSpace,
                right: TSizes.defultSpace,
                bottom: TSizes.defultSpace,
              ),
              child: Column(
                children: [
                  //..Rating & share
                  TRatingAndShare(),

                  //..Price, Titte, Stock, & Brand
                  TProductMetaData(),
                  //..Attrabutes
                  //..Descriptions
                  //..Reviews
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
