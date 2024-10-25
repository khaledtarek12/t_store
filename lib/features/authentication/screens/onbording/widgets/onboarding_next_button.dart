import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:t_store/features/authentication/controllers/onBording/onBording_controllers.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/device/device_utility.dart';
import 'package:t_store/utils/helpers/helper_function.dart';

class OnBordingNextButton extends StatelessWidget {
  const OnBordingNextButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunction.isDarkMode(context);
    return Positioned(
      right: TSizes.defultSpace,
      bottom: TDeviceUtility.getBottomNavigationBarHeight(),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: const CircleBorder(),
          backgroundColor: dark ? TColors.primary : TColors.black,
          side: BorderSide.none,
        ),
        onPressed: () => OnBordingControllers.instance.nextPage(),
        child: const Icon(CupertinoIcons.right_chevron),
      ),
    );
  }
}
