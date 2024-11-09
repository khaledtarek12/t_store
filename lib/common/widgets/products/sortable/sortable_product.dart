import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_store/common/layouts/grid_layout.dart';
import 'package:t_store/common/widgets/dropdown/custom_ios_dropdown.dart';
import 'package:t_store/common/widgets/products/product_cards/product_cart_virtical.dart';
import 'package:t_store/features/shop/controllers/all_product_contrroller.dart';
import 'package:t_store/features/shop/models/product_model.module.dart';
import 'package:t_store/utils/constants/sizes.dart';

class TSortableProduct extends StatelessWidget {
  const TSortableProduct({
    super.key,
    required this.products,
  });

  final List<ProductModel> products;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AllProductController());
    controller.assignProducts(products);
    return Column(
      children: [
        DropdownWithContextMenu(sortController: controller),
        const SizedBox(height: TSizes.spaceBtwScetions),
        Obx(() {
          return TGridLayout(
            itemCount: controller.products.length,
            itemBuilder: (_, index) =>
                TProductCartVertical(product: controller.products[index]),
          );
        })
      ],
    );
  }
}
