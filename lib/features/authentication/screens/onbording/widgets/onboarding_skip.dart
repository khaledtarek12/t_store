import 'package:flutter/material.dart';
import 'package:t_store/features/authentication/controllers/onBording/onBording_controllers.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/device/device_utility.dart';
import 'package:t_store/utils/helpers/helper_function.dart';

class OnBordingSkip extends StatelessWidget {
  const OnBordingSkip({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunction.isDarkMode(context);
    return Positioned(
      top: TDeviceUtility.getAppBarHeight(),
      right: TSizes.defultSpace,
      child: TextButton(
          onPressed: () => OnBordingControllers.instance.skipPage(),
          child: Text(
            'Skip',
            style: TextStyle(
                fontSize: TSizes.md,
                color: dark ? TColors.light : TColors.black),
          )),
    );
  }
}
