import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_store/common/widgets/success_screen/success_screen.dart';
import 'package:t_store/features/screens/login/login.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/constants/image_strings.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/constants/text_strings.dart';
import 'package:t_store/utils/helpers/helper_function.dart';

class VerifyEmailScreen extends StatelessWidget {
  const VerifyEmailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunction.isDarkMode(context);
    return Scaffold(
      appBar: AppBar(automaticallyImplyLeading: false, actions: [
        IconButton(
            onPressed: () => Get.offAll(const LoginScreen()),
            icon: Icon(
              CupertinoIcons.clear,
              color: dark ? TColors.light : TColors.balck,
            )),
      ]),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defultSpace),
          child: Column(
            children: [
              // images
              Image.asset(TImages.verifyEmail,
                  width: THelperFunction.screenWidth() * 0.6),
              const SizedBox(height: TSizes.spaceBtwScetions),

              // title and subtitle
              Text(TTexts.confirmEmailTitle,
                  style: Theme.of(context).textTheme.headlineMedium,
                  textAlign: TextAlign.center),
              const SizedBox(height: TSizes.spaceBtwItems),

              Text('support@gmail.com',
                  style: Theme.of(context).textTheme.labelLarge,
                  textAlign: TextAlign.center),
              const SizedBox(height: TSizes.spaceBtwItems),

              Text(TTexts.confirmEmailSubTitle,
                  style: Theme.of(context).textTheme.labelMedium,
                  textAlign: TextAlign.center),
              const SizedBox(height: TSizes.spaceBtwScetions),

              // buttons
              SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () => Get.to(
                            SuccessScreen(
                              image: TImages.emailCreatedSuccefully,
                              title: TTexts.yourAccountCreatedTitle,
                              subTitle: TTexts.yourAccountCreatedSubTitle,
                              onPressed: () => Get.off(const LoginScreen()),
                            ),
                          ),
                      child: const Text(TTexts.tcontinue))),
              const SizedBox(height: TSizes.spaceBtwItems),

              SizedBox(
                  width: double.infinity,
                  child: TextButton(
                      onPressed: () {}, child: const Text(TTexts.resendEmail))),
              const SizedBox(height: TSizes.spaceBtwItems),
            ],
          ),
        ),
      ),
    );
  }
}
