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
    return Center(
      child: Padding(
        padding: EdgeInsets.only(top: THelperFunction.screenHeight() * .155),
        child: Column(
          children: [
            Lottie.asset(animation, width: MediaQuery.of(context).size.width),
            const SizedBox(height: TSizes.spaceBtwItems * 2),
            Text(text,
                style: Theme.of(context).textTheme.titleMedium!.apply(
                    color: THelperFunction.isDarkMode(context)
                        ? TColors.white
                        : TColors.dark),
                textAlign: TextAlign.center),
            const SizedBox(height: TSizes.defultSpace),
            showAction
                ? SizedBox(
                    width: 250,
                    child: OutlinedButton(
                        onPressed: onActionPressed,
                        style: OutlinedButton.styleFrom(
                            side: BorderSide(color: Colors.transparent),
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
