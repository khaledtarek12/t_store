import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_store/common/widgets/appbar/custom_appbar.dart';
import 'package:t_store/common/widgets/loading/animation_loader.dart';
import 'package:t_store/features/shop/controllers/cart_controller.dart';
import 'package:t_store/features/shop/screens/cart/widgets/cart_items.dart';
import 'package:t_store/features/shop/screens/checkout/checkout.dart';
import 'package:t_store/navigation_menu.dart';
import 'package:t_store/utils/constants/image_strings.dart';
import 'package:t_store/utils/constants/sizes.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = CartController.instance;
    return Scaffold(
      appBar: TAppbar(
          showBackArrow: true,
          title:
              Text('Cart', style: Theme.of(context).textTheme.headlineSmall)),
      body: Obx(
        () {
          final emptyAnimationWidget = TAnimationLoaderWidgets(
            showAction: true,
            actionText: 'Let\'s fill it',
            onActionPressed: () => Get.off(() => const NavigationMenu()),
            text: 'Whoops! Cart Is EMPTY',
            animation: TImages.cartAnimation,
          );

          return controller.cartItems.isEmpty
              ? emptyAnimationWidget
              : SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(TSizes.defultSpace),
                    child: SingleChildScrollView(child: TCartItems()),
                  ),
                );
        },
      ),
      bottomNavigationBar: controller.cartItems.isNotEmpty
          ? Padding(
              padding: const EdgeInsets.all(TSizes.defultSpace),
              child: ElevatedButton(
                onPressed: () => Get.to(() => const CheckoutScreen()),
                child: Obx(
                  () {
                    return Text(
                        'Checkout \$${controller.totalCartPrice.value}');
                  },
                ),
              ),
            )
          : null,
    );
  }
}
