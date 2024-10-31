import 'package:flutter/material.dart';
import 'package:t_store/common/layouts/grid_layout.dart';
import 'package:t_store/common/widgets/appbar/custom_appbar.dart';
import 'package:t_store/common/widgets/dropdown/custom_ios_dropdown.dart';
import 'package:t_store/common/widgets/products/product_cards/product_cart_virtical.dart';
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defultSpace),
          child: Column(
            children: [
              DropdownWithContextMenu(),
              const SizedBox(height: TSizes.spaceBtwScetions),
              TGridLayout(
                itemCount: 8,
                itemBuilder: (p0, p1) => const TProductCartVertical(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
