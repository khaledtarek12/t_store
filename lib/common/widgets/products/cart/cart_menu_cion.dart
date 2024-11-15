import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store/features/shop/controllers/cart_controller.dart';
import 'package:t_store/features/shop/screens/cart/cart.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/helpers/helper_function.dart';

class TCartCounterIcon extends StatelessWidget {
  const TCartCounterIcon({
    super.key,
    this.iconColor,
  });

  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CartController());
    final black = THelperFunction.isDarkMode(context);
    return IconButton(
        onPressed: () => Get.to(() => CartScreen()),
        icon: Badge(
          backgroundColor: black ? TColors.white : Colors.black,
          offset: const Offset(8, -10),
          label: Obx(
            () {
              return Text(controller.noOfCartItem.value.toString(),
                  style: Theme.of(context)
                      .textTheme
                      .labelLarge!
                      .apply(color: black ? Colors.black : Colors.white));
            },
          ),
          child: Icon(
            Iconsax.shopping_bag,
            color: iconColor ?? (black ? TColors.white : Colors.black),
          ),
        ));
  }
}
