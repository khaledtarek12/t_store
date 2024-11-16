import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_store/common/widgets/appbar/custom_appbar.dart';
import 'package:t_store/common/widgets/custom_shapes/container/rounded_container.dart';
import 'package:t_store/common/widgets/products/cart/coupone_code.dart';
import 'package:t_store/features/shop/controllers/cart_controller.dart';
import 'package:t_store/features/shop/controllers/order_controller.dart';
import 'package:t_store/features/shop/screens/cart/widgets/cart_items.dart';
import 'package:t_store/features/shop/screens/checkout/widgets/billing_address_section.dart';
import 'package:t_store/features/shop/screens/checkout/widgets/billing_amount_section.dart';
import 'package:t_store/features/shop/screens/checkout/widgets/billing_payment_section.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/helpers/helper_function.dart';
import 'package:t_store/utils/helpers/pricing_calculator.dart';
import 'package:t_store/utils/popups/loaders.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cartController = CartController.instance;
    final subTotal = cartController.totalCartPrice.value;
    final orderController = Get.put(OrderController());
    final totalAmount = TPricingCalculator.catcutateTotatPrice(subTotal, 'EG');
    final dark = THelperFunction.isDarkMode(context);
    return Scaffold(
      appBar: TAppbar(
          showBackArrow: true,
          title: Text('Checkout',
              style: Theme.of(context).textTheme.headlineSmall)),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defultSpace),
          child: Column(
            children: [
              //....Items in Cart
              const TCartItems(showAddRemoveButtons: false),
              const SizedBox(height: TSizes.spaceBtwScetions),

              //...Coupon
              const TCouponeCode(),
              const SizedBox(height: TSizes.spaceBtwScetions),

              //...Biling Section
              TRoundedContainer(
                padding: const EdgeInsets.all(TSizes.md),
                showBorder: true,
                backgroundCoIor: dark ? TColors.dark : TColors.white,
                child: const Column(
                  children: [
                    //..pricing
                    TBillingAmountSection(),
                    SizedBox(height: TSizes.spaceBtwItems),

                    //..devider
                    Divider(),
                    SizedBox(height: TSizes.spaceBtwItems),

                    //..Payement Method
                    TBillingPaymentSection(),
                    SizedBox(height: TSizes.spaceBtwItems),

                    //..Address
                    TBillingAddressSection(),
                    SizedBox(height: TSizes.spaceBtwItems),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(TSizes.defultSpace),
        child: ElevatedButton(
            onPressed: subTotal >0  ? ()=> orderController.processOrder(totalAmount): ()=>TLoaders.warningSnakBar(
              title: 'Empty Cart',
              message: 'Add items in the cart in order to proceed.',
            ),
            child: Text(
                'Checkout \$$totalAmount')),
      ),
    );
  }
}
