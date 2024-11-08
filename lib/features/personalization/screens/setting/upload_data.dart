import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store/common/widgets/appbar/custom_appbar.dart';
import 'package:t_store/common/widgets/list_tiles/settings_menu_tile.dart';
import 'package:t_store/common/widgets/texts/seaction_heading.dart';
import 'package:t_store/data/dummy_data.dart';
import 'package:t_store/data/repositories/banners/banners_repositry.dart';
import 'package:t_store/data/repositories/categories/category_repositry.dart';
import 'package:t_store/data/repositories/product/product_repositry.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/constants/sizes.dart';

class UploadDataScreen extends StatelessWidget {
  const UploadDataScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final product = ProductRepositry.instance;
    final category = CategoryRepositry.instance;
    final banner = BannersRepositry.instance;
    return Scaffold(
      appBar: const TAppbar(showBackArrow: true, title: Text('Upload Data')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
              top: TSizes.defultSpace,
              left: TSizes.defultSpace,
              bottom: TSizes.defultSpace,
              right: TSizes.md),
          child: Column(
            children: [
              const TSectionHeading(
                  title: 'Main Record', showActionButton: false),
              const SizedBox(height: TSizes.spaceBtwItems),
              TSettingsMenuTile(
                  isSubtitle: false,
                  icon: Iconsax.category,
                  title: 'Upload Categories',
                  trailing: IconButton(
                      onPressed: () =>
                          category.uploadDummyData(TDummyData.categories),
                      icon: const Icon(Iconsax.arrow_circle_up3,
                          size: 28, color: TColors.primary))),
              const SizedBox(height: TSizes.spaceBtwItems),
              TSettingsMenuTile(
                  isSubtitle: false,
                  icon: Iconsax.shop,
                  title: 'Upload Brands',
                  trailing: IconButton(
                      onPressed: () {},
                      icon: const Icon(Iconsax.arrow_circle_up3,
                          size: 28, color: TColors.primary))),
              const SizedBox(height: TSizes.spaceBtwItems),
              TSettingsMenuTile(
                  isSubtitle: false,
                  icon: Iconsax.shopping_cart,
                  title: 'Upload Product',
                  trailing: IconButton(
                      onPressed: () =>
                          product.uploadDummyData(TDummyData.products),
                      icon: const Icon(Iconsax.arrow_circle_up3,
                          size: 28, color: TColors.primary))),
              const SizedBox(height: TSizes.spaceBtwItems),
              TSettingsMenuTile(
                  isSubtitle: false,
                  icon: Iconsax.image,
                  title: 'Upload Banners',
                  trailing: IconButton(
                      onPressed: () =>
                          banner.uploadDummyData(TDummyData.banners),
                      icon: const Icon(Iconsax.arrow_circle_up3,
                          size: 28, color: TColors.primary))),
              const SizedBox(height: TSizes.spaceBtwScetions),
              const TSectionHeading(
                  title: 'Relation Ships', showActionButton: false),
              Text('Make sure you have already uploaded all the content above',
                  style: Theme.of(context).textTheme.bodyMedium),
              const SizedBox(height: TSizes.spaceBtwItems),
              TSettingsMenuTile(
                  isSubtitle: false,
                  icon: Iconsax.link,
                  title: 'Upload Brands & Categories Relation Data',
                  trailing: IconButton(
                      onPressed: () {},
                      icon: const Icon(Iconsax.arrow_circle_up3,
                          size: 28, color: TColors.primary))),
              const SizedBox(height: TSizes.spaceBtwItems),
              TSettingsMenuTile(
                  isSubtitle: false,
                  icon: Iconsax.link,
                  title: 'Upload Product Categories Relational Data',
                  trailing: IconButton(
                      onPressed: () {},
                      icon: const Icon(Iconsax.arrow_circle_up3,
                          size: 28, color: TColors.primary))),
              const SizedBox(height: TSizes.spaceBtwItems),
            ],
          ),
        ),
      ),
    );
  }
}
