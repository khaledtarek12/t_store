import 'package:flutter/material.dart';
import 'package:t_store/common/widgets/custom_shapes/container/rounded_container.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/helpers/helper_function.dart';

class TCouponeCode extends StatelessWidget {
  const TCouponeCode({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunction.isDarkMode(context);

    return TRoundedContainer(
      showBorder: true,
      backgroundCoIor: dark ? TColors.dark : TColors.white,
      padding: const EdgeInsets.only(
        top: TSizes.sm,
        bottom: TSizes.sm,
        right: TSizes.sm,
        left: TSizes.md,
      ),
      child: Row(
        children: [
          Flexible(
            child: TextFormField(
              decoration: const InputDecoration(
                hintText: 'Have a Promo code? Enter here',
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
              ),
            ),
          ),
          SizedBox(
              width: 80,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      foregroundColor: dark
                          ? TColors.white.withValues(alpha: 0.5)
                          : TColors.dark.withValues(alpha: 0.5),
                      backgroundColor: Colors.grey.withValues(alpha: 0.2),
                      side: BorderSide(
                          color: Colors.grey.withValues(alpha: 0.1))),
                  onPressed: () {},
                  child: const Text('Apply')))
        ],
      ),
    );
  }
}
