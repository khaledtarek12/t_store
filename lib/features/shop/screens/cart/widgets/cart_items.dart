import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_store/common/widgets/products/cart/add_remove_button.dart';
import 'package:t_store/common/widgets/products/cart/cart_item.dart';
import 'package:t_store/common/widgets/texts/product_price_text.dart';
import 'package:t_store/features/shop/controllers/cart_controller.dart';
import 'package:t_store/utils/constants/sizes.dart';

class TCartItems extends StatelessWidget {
  const TCartItems({super.key, this.showAddRemoveButtons = true});

  final bool showAddRemoveButtons;

  @override
  Widget build(BuildContext context) {
    final controller = CartController.instance;
    return Obx(
      () {
        return ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: controller.cartItems.length,
          separatorBuilder: (context, index) =>
              const SizedBox(height: TSizes.spaceBtwScetions),
          itemBuilder: (context, index) => Obx(
            () {
              final item = controller.cartItems[index];
              return Column(
                children: [
                  TCartItem(cartItem: item),
                  if (showAddRemoveButtons)
                    const SizedBox(height: TSizes.spaceBtwItems),
                  if (showAddRemoveButtons)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            SizedBox(width: 70),
                            TProdcutQuantityWithAddandRemove(
                              quantity: item.quantity,
                              add: () => controller.addOneToCart(item),
                              remove: () => controller.removeOneFromCart(item),
                            ),
                          ],
                        ),
                        TProductPriceText(
                            price:
                                (item.price * item.quantity).toStringAsFixed(1))
                      ],
                    )
                ],
              );
            },
          ),
        );
      },
    );
  }
}
