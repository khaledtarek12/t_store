import 'package:flutter/material.dart';
import 'package:t_store/features/shop/controllers/cart_controller.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/helpers/pricing_calculator.dart';

class TBillingAmountSection extends StatelessWidget {
  const TBillingAmountSection({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = CartController.instance;
    final subTotal = controller.totalCartPrice.value;
    return Column(
      children: [
        //...SubTotal
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Subtotal', style: Theme.of(context).textTheme.bodyMedium),
            Text('\$$subTotal', style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
        const SizedBox(height: TSizes.spaceBtwItems / 2),

        //..Shiping fee
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Shipping Fee', style: Theme.of(context).textTheme.bodyMedium),
            Text(
                '\$${TPricingCalculator.calcuLateShippingCost(subTotal, 'EG')}',
                style: Theme.of(context).textTheme.labelLarge),
          ],
        ),
        const SizedBox(height: TSizes.spaceBtwItems / 2),

        //..Tax fee
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Tax Fee', style: Theme.of(context).textTheme.bodyMedium),
            Text('\$${TPricingCalculator.calculateTax(subTotal, 'EG')}',
                style: Theme.of(context).textTheme.labelLarge),
          ],
        ),
        const SizedBox(height: TSizes.spaceBtwItems / 2),

        //..Order Total
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Order Total', style: Theme.of(context).textTheme.bodyMedium),
            Text('\$${TPricingCalculator.catcutateTotatPrice(subTotal, 'EG')}',
                style: Theme.of(context).textTheme.labelLarge),
          ],
        ),
      ],
    );
  }
}
