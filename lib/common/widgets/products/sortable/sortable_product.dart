import 'package:flutter/material.dart';
import 'package:t_store/common/layouts/grid_layout.dart';
import 'package:t_store/common/widgets/dropdown/custom_ios_dropdown.dart';
import 'package:t_store/common/widgets/products/product_cards/product_cart_virtical.dart';
import 'package:t_store/features/shop/models/product_model.module.dart';
import 'package:t_store/utils/constants/sizes.dart';

class TSortableProduct extends StatelessWidget {
  const TSortableProduct({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DropdownWithContextMenu(),
        const SizedBox(height: TSizes.spaceBtwScetions),
        TGridLayout(
          itemCount: 8,
          itemBuilder: (p0, p1) =>
              TProductCartVertical(product: ProductModel.empty()),
        )
      ],
    );
  }
}
