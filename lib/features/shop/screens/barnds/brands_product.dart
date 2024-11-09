import 'package:flutter/material.dart';
import 'package:t_store/common/widgets/appbar/custom_appbar.dart';
import 'package:t_store/common/widgets/brands/brand_cards.dart';
import 'package:t_store/common/widgets/products/sortable/sortable_product.dart';
import 'package:t_store/features/shop/models/brand_model.module.dart';
import 'package:t_store/utils/constants/sizes.dart';

class BrandsProductScreen extends StatelessWidget {
  const BrandsProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: const TAppbar(title: Text('Nike')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(TSizes.defultSpace),
        child: Column(
          children: [
            TBrandCard(showBoder: true, brand: BrandModel.empty(),),
            const SizedBox(height: TSizes.spaceBtwScetions),
            const TSortableProduct(
              products: [],
            ),
          ],
        ),
      ),
    );
  }
}
