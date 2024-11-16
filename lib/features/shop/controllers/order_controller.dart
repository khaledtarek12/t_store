import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_store/common/widgets/success_screen/success_screen.dart';
import 'package:t_store/data/repositories/authentication/authentication_repository.dart';
import 'package:t_store/data/repositories/orders/order_repositry.dart';
import 'package:t_store/features/personalization/controllers/address_controller.dart';
import 'package:t_store/features/shop/controllers/cart_controller.dart';
import 'package:t_store/features/shop/controllers/checkout_controller.dart';
import 'package:t_store/features/shop/models/order_model.module.dart';
import 'package:t_store/navigation_menu.dart';
import 'package:t_store/utils/constants/enums.dart';
import 'package:t_store/utils/constants/image_strings.dart';
import 'package:t_store/utils/popups/full_screen_loader.dart';
import 'package:t_store/utils/popups/loaders.dart';

class OrderController extends GetxController {
  static OrderController get instance => Get.find();

  // variables
  final cartController = CartController.instance;
  final addressController = AddressController.instance;
  final checkoutController = CheckoutController.instance;
  final orderRepositry = Get.put(OrderRepositry());

  /// Fetch user's order history
  Future<List<OrderModel>> fetchUserOrders() async {
    try {
      final userOrders = await orderRepositry.fetchUserOrders();
      return userOrders;
    } catch (e) {
      TLoaders.errorSnakBar(title: 'Oh Snap!', message: e.toString());
      return [];
    }
  }

  /// Add methods for order processing
  void processOrder(double totalAmount) async {
    try {
      TFullScreenLoader.openLoadingDialog(
          'Processing your order...', TImages.pencilWaking);

      // Get user Id
      final userId = AuthenticationRepository.instance.authUser?.uid;

      if (userId!.isEmpty) return;

      // Add Details
      final order = OrderModel(
        id: UniqueKey().toString(),
        status: OrderStatus.pending,
        totalAmount: totalAmount,
        orderDate: DateTime.now(),
        paymentMethod: checkoutController.selectedPaymentMenthod.value.name,
        address: addressController.selectedAddress.value,
        deliveryDate: DateTime.now(),
        items: cartController.cartItems.toList(),
      );

      // Save the order to Firestone
      await orderRepositry.saveOrder(order, userId);

      // Undate the cart status
      cartController.clearCart();

      Get.off(
        () => SuccessScreen(
          image: TImages.orderConfirmed,
          isIamge: false,
          title: 'Payment Success!',
          subTitle: 'Your item will be shipped soon!',
          onPressed: () => Get.offAll(() => NavigationMenu()),
        ),
      );
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.warningSnakBar(title: 'Oh Snap!', message: e.toString());
    }
  }
}
