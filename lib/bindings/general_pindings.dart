import 'package:get/get.dart';
import 'package:t_store/features/personalization/controllers/address_controller.dart';
import 'package:t_store/features/shop/controllers/checkout_controller.dart';
import 'package:t_store/features/shop/controllers/products/variation_controller.dart';
import 'package:t_store/utils/helpers/network_manager.dart';

class GeneralPindings extends Bindings {
  @override
  void dependencies() {
    Get.put(NetworkManager());
    Get.put(VariationController());
    Get.put(AddressController());
    Get.put(CheckoutController());
    Get.put(AddressController());
  }
}
