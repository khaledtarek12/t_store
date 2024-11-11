import 'package:flutter/material.dart';
import 'package:t_store/common/shammer/category_shammer.dart';
import 'package:t_store/common/widgets/appbar/custom_appbar.dart';
import 'package:t_store/common/widgets/brands/brand_cards.dart';
import 'package:t_store/common/widgets/products/sortable/sortable_product.dart';
import 'package:t_store/features/shop/controllers/brand_controller.dart';
import 'package:t_store/features/shop/models/brand_model.module.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/helpers/cloud_helper_function.dart';

class BrandsProductScreen extends StatelessWidget {
  const BrandsProductScreen({super.key, required this.brand});

  final BrandModel brand;

  @override
  Widget build(BuildContext context) {
    final controller = BrandController.instance;
    return Scaffold(
      appBar: TAppbar(title: Text(brand.name)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(TSizes.defultSpace),
        child: Column(
          children: [
            TBrandCard(
              showBoder: true,
              brand: brand,
            ),
            const SizedBox(height: TSizes.spaceBtwScetions),
            FutureBuilder(
                future: controller.getBrandProducts(brandId: brand.id),
                builder: (context, snapshot) {
                  const loader = TVerticalProductShimmer();
                  final widget = TCloudHelperFunction.checkMultiRecordState(
                      snapshot: snapshot, loader: loader);

                  if (widget != null) return widget;

                  final brandProducts = snapshot.data!;
                  return TSortableProduct(
                    products: brandProducts,
                  );
                }),
          ],
        ),
      ),
    );
  }
}
