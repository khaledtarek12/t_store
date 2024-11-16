import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store/common/widgets/custom_shapes/container/rounded_container.dart';
import 'package:t_store/features/shop/models/payment_method_model.module.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/helpers/helper_function.dart';

class TPaymentTile extends StatelessWidget {
  const TPaymentTile({super.key, required this.paymentMethod});

  final PaymentMethodModel paymentMethod;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: ListTile(
        contentPadding: EdgeInsets.all(0),
        leading: TRoundedContainer(
          width: 60,
          height: 60,
          backgroundCoIor: THelperFunction.isDarkMode(context)
              ? TColors.light
              : TColors.white,
          padding: EdgeInsets.all(TSizes.sm),
          child: Image.asset(paymentMethod.image, fit: BoxFit.contain),
        ),
        title: Text(paymentMethod.name),
        trailing: Icon(Iconsax.arrow_right_34),
      ),
    );
  }
}
