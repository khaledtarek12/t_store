import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store/features/authentication/controllers/login/login_controller.dart';
import 'package:t_store/features/authentication/screens/password_configration/forget_password.dart';
import 'package:t_store/features/authentication/screens/signup/signup.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/constants/text_strings.dart';
import 'package:t_store/utils/helpers/helper_function.dart';
import 'package:t_store/utils/validators/validation.dart';

class LoginFormPage extends StatelessWidget {
  const LoginFormPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    final dark = THelperFunction.isDarkMode(context);
    return Form(
      key: controller.loginFormKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: TSizes.spaceBtwScetions),
        child: Column(
          children: [
            //   Email
            TextFormField(
              focusNode: controller.fEmailNode,
              controller: controller.email,
              textInputAction: TextInputAction.next,
              validator: (value) => TValidator.emailValidator(value),
              decoration: const InputDecoration(
                  prefixIcon: Icon(Iconsax.direct_right),
                  labelText: TTexts.email),
              onFieldSubmitted: (value) =>
                  FocusScope.of(context).requestFocus(controller.fPasswordNode),
            ),

            const SizedBox(height: TSizes.spaceBtwInputFields),

            //  Password
            Obx(() {
              return TextFormField(
                focusNode: controller.fPasswordNode,
                controller: controller.password,
                obscureText: controller.hidePassword.value,
                textInputAction: TextInputAction.done,
                validator: (value) =>
                    TValidator.displayNamevalidator('Password', value),
                decoration: InputDecoration(
                  prefixIcon: const Icon(Iconsax.password_check),
                  labelText: TTexts.password,
                  suffixIcon: IconButton(
                      onPressed: () {
                        controller.hidePassword.value =
                            !controller.hidePassword.value;
                      },
                      icon: Icon(
                        controller.hidePassword.value
                            ? Iconsax.eye_slash
                            : Iconsax.eye,
                      )),
                ),
                onFieldSubmitted: (value) => FocusScope.of(context).unfocus(),
              );
            }),
            const SizedBox(height: TSizes.spaceBtwInputFields / 2),

            //Remeber me and forrget password
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //Remeber me
                Row(
                  children: [
                    Obx(() {
                      return Checkbox(
                          value: controller.rememberMe.value,
                          onChanged: (value) {
                            controller.rememberMe.value =
                                !controller.rememberMe.value;
                          });
                    }),
                    const Text(TTexts.rememberMe),
                  ],
                ),

                //Forrget password
                TextButton(
                    onPressed: () => Get.to(() => const ForgetPasswordScreen()),
                    child: const Text(TTexts.forrgetPassword)),
              ],
            ),
            const SizedBox(height: TSizes.spaceBtwScetions),

            //Sign in button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: () => controller.emailAndPasswordSignin(),
                  child: const Text(TTexts.signIn)),
            ),
            const SizedBox(height: TSizes.spaceBtwItems),

            //Create accout button
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                    side: BorderSide(
                        color: dark ? TColors.darkGrey : TColors.grey,
                        width: 2)),
                child: const Text(TTexts.createAccount),
                onPressed: () {
                  Get.to(() => const SignupScreen());
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
