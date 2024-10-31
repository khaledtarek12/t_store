import 'package:flutter/material.dart';
import 'package:t_store/common/widgets/appbar/custom_appbar.dart';
import 'package:t_store/common/widgets/products/sortable/sortable_product.dart';
import 'package:t_store/utils/constants/sizes.dart';

class AllProdcutScreen extends StatelessWidget {
  const AllProdcutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppbar(
          title: Text('Popular Prodcut',
              style: Theme.of(context).textTheme.headlineSmall),
          showBackArrow: true),
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(TSizes.defultSpace),
          child: TSortableProduct(),
        ),
      ),
    );
  }
}
