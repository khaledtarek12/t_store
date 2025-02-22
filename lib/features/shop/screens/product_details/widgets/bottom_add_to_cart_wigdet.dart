import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store/common/widgets/icons/circular_icons.dart';
import 'package:t_store/features/shop/controllers/cart_controller.dart';
import 'package:t_store/features/shop/models/product_model.module.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/helpers/helper_function.dart';

class TBottomAddToCart extends StatelessWidget {
  const TBottomAddToCart({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunction.isDarkMode(context);
    final controller = CartController.instance;
    controller.updateAllreadyAddedProductCount(product);
    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: TSizes.defultSpace, vertical: TSizes.defultSpace / 2),
      decoration: BoxDecoration(
        color: dark ? TColors.darkerGrey : TColors.light,
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(TSizes.cardRadiusLg),
          topLeft: Radius.circular(TSizes.cardRadiusLg),
        ),
      ),
      child: Obx(
        () {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  TcircularIcon(
                    icon: Iconsax.minus,
                    backgroundColor: TColors.darkGrey,
                    width: 40,
                    height: 40,
                    color: TColors.white,
                    onPressed: () => controller.productQuantityInCart.value < 1
                        ? null
                        : controller.productQuantityInCart.value -= 1,
                  ),
                  const SizedBox(width: TSizes.defultSpace),
                  Text(controller.productQuantityInCart.value.toString(),
                      style: Theme.of(context).textTheme.titleSmall),
                  const SizedBox(width: TSizes.defultSpace),
                  TcircularIcon(
                    icon: Iconsax.add,
                    backgroundColor: TColors.black,
                    width: 40,
                    height: 40,
                    color: TColors.white,
                    onPressed: () =>
                        controller.productQuantityInCart.value += 1,
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: controller.productQuantityInCart.value < 1
                    ? null
                    : () => controller.addToCart(product),
                style: OutlinedButton.styleFrom(
                  splashFactory: NoSplash.splashFactory,
                  padding: const EdgeInsets.all(TSizes.md),
                  backgroundColor: controller.productQuantityInCart.value < 1
                      ? TColors.black.withValues(alpha: 0.5)
                      : TColors.black,
                  side: const BorderSide(color: TColors.black, width: 2),
                ),
                child: const Text('Add to Cart'),
              )
            ],
          );
        },
      ),
    );
  }
}
