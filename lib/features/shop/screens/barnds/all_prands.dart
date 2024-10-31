import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_store/common/layouts/grid_layout.dart';
import 'package:t_store/common/widgets/appbar/custom_appbar.dart';
import 'package:t_store/common/widgets/brands/brand_cards.dart';
import 'package:t_store/common/widgets/texts/seaction_heading.dart';
import 'package:t_store/features/shop/screens/barnds/brands_product.dart';
import 'package:t_store/utils/constants/sizes.dart';

class AllPrandsScreen extends StatelessWidget {
  const AllPrandsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TAppbar(title: Text('Brand'), showBackArrow: true),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defultSpace),
          child: Column(
            children: [
              const TSectionHeading(title: 'Brands', showActionButton: false),
              const SizedBox(height: TSizes.spaceBtwItems),

              //...Brands
              TGridLayout(
                mainAxisExtent: 80,
                itemCount: 10,
                itemBuilder: (context, index) => TBrandCard(
                  showBoder: true,
                  onTap: () => Get.to(() => const BrandsProductScreen()),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
