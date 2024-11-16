import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_store/data/repositories/authentication/authentication_repository.dart';
import 'package:t_store/features/authentication/controllers/signup/verify_email_controller.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/constants/image_strings.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/constants/text_strings.dart';
import 'package:t_store/utils/helpers/helper_function.dart';

class VerifyEmailScreen extends StatelessWidget {
  const VerifyEmailScreen({super.key, this.email});

  final String? email;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(VerifyEmailController());
    final dark = THelperFunction.isDarkMode(context);
    return Scaffold(
      appBar: AppBar(automaticallyImplyLeading: false, actions: [
        IconButton(
            onPressed: () => AuthenticationRepository.instance.logout(),
            icon: Icon(
              CupertinoIcons.clear,
              color: dark ? TColors.light : TColors.black,
            )),
      ]),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defultSpace),
          child: Column(
            children: [
              // images
              Image.asset(TImages.checkEmaiDark,
                  width: THelperFunction.screenWidth() * 0.8),
              const SizedBox(height: TSizes.spaceBtwScetions),

              // title and subtitle
              Text(TTexts.confirmEmailTitle,
                  style: Theme.of(context).textTheme.headlineMedium,
                  textAlign: TextAlign.center),
              const SizedBox(height: TSizes.spaceBtwItems),

              Text(email ?? '',
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
                      onPressed: () =>
                          controller.checkEmailVerificationStatus(),
                      child: const Text(TTexts.tcontinue))),
              const SizedBox(height: TSizes.spaceBtwItems),

              SizedBox(
                  width: double.infinity,
                  child: TextButton(
                      onPressed: () => controller.sendEmailVerification,
                      child: const Text(TTexts.resendEmail))),
              const SizedBox(height: TSizes.spaceBtwItems),
            ],
          ),
        ),
      ),
    );
  }
}
