import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store/features/shop/controllers/cart_controller.dart';
import 'package:t_store/features/shop/models/product_model.module.dart';
import 'package:t_store/features/shop/screens/product_details/product_details.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/constants/enums.dart';
import 'package:t_store/utils/constants/sizes.dart';

class ProductCardAddToCartButton extends StatelessWidget {
  const ProductCardAddToCartButton({
    super.key,
    required this.product,
  });

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final controller = CartController.instance;
    return InkWell(
      onTap: () {
        // If the product have variatiations then show the product Details for variation selection.
        // Else add product to the cart.
        if (product.productType == ProductType.single.toString()) {
          final cartItem = controller.convertToCartItem(product, 1);
          controller.addOneToCart(cartItem);
        } else {
          Get.to(() => ProductDetailsScreen(product: product));
        }
      },
      child: Obx(
        () {
          final productQuantityInCart =
              controller.getProductQuantityInCart(product.id);
          return Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(TSizes.cardRadiusMd),
                  bottomRight: Radius.circular(TSizes.productImageRadius),
                ),
                color:
                    productQuantityInCart > 0 ? TColors.primary : TColors.dark),
            child: SizedBox(
                width: TSizes.iconLg * 1.2,
                height: TSizes.iconLg * 1.2,
                child: Center(
                    child: productQuantityInCart > 0
                        ? Text(
                            productQuantityInCart.toString(),
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .apply(color: TColors.white),
                          )
                        : Icon(Iconsax.add, color: TColors.white))),
          );
        },
      ),
    );
  }
}
