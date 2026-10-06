import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/helpers/helper_function.dart';

class TAnimationLoaderWidgets extends StatelessWidget {
  const TAnimationLoaderWidgets({
    super.key,
    required this.text,
    required this.animation,
    this.showAction = false,
    this.actionText,
    this.onActionPressed,
  });

  final String text;
  final String animation;
  final bool showAction;
  final String? actionText;
  final VoidCallback? onActionPressed;

  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.sizeOf(context);
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: TSizes.defultSpace),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Lottie.asset(
              animation,
              width: screen.width * .8,
              height: screen.height * .3,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: TSizes.spaceBtwItems * 2),
            Text(text,
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .apply(color: TColors.white),
                textAlign: TextAlign.center),
            const SizedBox(height: TSizes.defultSpace),
            showAction
                ? SizedBox(
                    width: 250,
                    child: OutlinedButton(
                        onPressed: onActionPressed,
                        style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: Colors.transparent),
                            backgroundColor: THelperFunction.isDarkMode(context)
                                ? Colors.black
                                : TColors.dark),
                        child: Text(
                          actionText!,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .apply(color: TColors.light),
                        )),
                  )
                : const SizedBox()
          ],
        ),
      ),
    );
  }
}
