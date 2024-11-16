import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_store/common/widgets/custom_shapes/container/rounded_container.dart';
import 'package:t_store/common/widgets/texts/seaction_heading.dart';
import 'package:t_store/features/shop/controllers/checkout_controller.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/helpers/helper_function.dart';

class TBillingPaymentSection extends StatelessWidget {
  const TBillingPaymentSection({super.key});

  @override
  Widget build(BuildContext context) {
    var darkMode = THelperFunction.isDarkMode(context);
    final controller = CheckoutController.instance;
    return Column(
      children: [
        TSectionHeading(
          title: 'Payment Method',
          buttonTitle: 'Change',
          onPressed: () {
            controller.selectPaymentMethod(context);
          },
        ),
        const SizedBox(height: TSizes.spaceBtwItems / 2),
        Obx(
          () {
            return Row(
              children: [
                TRoundedContainer(
                  width: 60,
                  height: 60,
                  backgroundCoIor: darkMode ? TColors.light : TColors.white,
                  padding: const EdgeInsets.all(TSizes.sm),
                  child: Image.asset(
                      controller.selectedPaymentMenthod.value.image,
                      fit: BoxFit.contain),
                ),
                const SizedBox(width: TSizes.spaceBtwItems / 2),
                Text(controller.selectedPaymentMenthod.value.name,
                    style: Theme.of(context).textTheme.bodyLarge),
              ],
            );
          },
        )
      ],
    );
  }
}
