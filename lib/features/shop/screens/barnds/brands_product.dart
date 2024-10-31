import 'package:flutter/material.dart';
import 'package:t_store/common/widgets/appbar/custom_appbar.dart';
import 'package:t_store/common/widgets/brands/brand_cards.dart';
import 'package:t_store/common/widgets/products/sortable/sortable_product.dart';
import 'package:t_store/utils/constants/sizes.dart';

class BrandsProductScreen extends StatelessWidget {
  const BrandsProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: TAppbar(title: Text('Nike')),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(TSizes.defultSpace),
        child:  Column(
          children: [
            TBrandCard(showBoder: true),
            SizedBox(height: TSizes.spaceBtwScetions),
            TSortableProduct(),
          ],
        ),
      ),
    );
  }
}
