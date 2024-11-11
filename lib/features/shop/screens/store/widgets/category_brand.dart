import 'package:flutter/material.dart';
import 'package:t_store/common/shammer/boxs_shammer.dart';
import 'package:t_store/common/shammer/list_tile_sahmmer.dart';
import 'package:t_store/common/widgets/brands/brand_show_case.dart';
import 'package:t_store/features/shop/controllers/brand_controller.dart';
import 'package:t_store/features/shop/models/category_model.module.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/helpers/cloud_helper_function.dart';

class CategoryBrands extends StatelessWidget {
  const CategoryBrands({super.key, required this.category});

  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    final controller = BrandController.instance;
    return FutureBuilder(
        future: controller.getBrandForCategory(category.id),
        builder: (context, snapshot) {
          /// Handle Loader, No Record, OR Error Yesscge
          const loader = Column(
            children: [
              TListTileSahmmer(),
              SizedBox(height: TSizes.spaceBtwItems),
              TBoxesShammer(),
              SizedBox(height: TSizes.spaceBtwItems),
            ],
          );

          final widget = TCloudHelperFunction.checkMultiRecordState(
              snapshot: snapshot, loader: loader);
          if (widget != null) return widget;

          final brands = snapshot.data!;

          return ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: brands.length,
            itemBuilder: (context, index) {
              final brand = brands[index];
              return FutureBuilder(
                  future:
                      controller.getBrandProducts(brandId: brand.id, limit: 3),
                  builder: (context, snapshot) {
                    final widget = TCloudHelperFunction.checkMultiRecordState(
                        snapshot: snapshot,
                        loader: loader,
                        nothingFound: const SizedBox());
                    if (widget != null) return widget;

                    final products = snapshot.data!;
                    return TBrandShowCase(
                      images: products.map((e) => e.thumbanil).toList(),
                      brand: brand,
                    );
                  });
            },
          );
        });
  }
}
