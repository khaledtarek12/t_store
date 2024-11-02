import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store/features/authentication/controllers/signup/signup_controller.dart';
import 'package:t_store/features/authentication/screens/signup/widgets/terms_and_condition_check_box.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/constants/text_strings.dart';
import 'package:t_store/utils/validators/validation.dart';

class SingUpFormPage extends StatelessWidget {
  const SingUpFormPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignupController());
    return Form(
      key: controller.signUpFormKey,
      child: Column(
        children: [
          // First and LastName
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  focusNode: controller.fNameNode,
                  controller: controller.fristName,
                  textInputAction: TextInputAction.next,
                  validator: (value) =>
                      TValidator.displayNamevalidator('First name', value),
                  expands: false,
                  decoration: const InputDecoration(
                    labelText: TTexts.fristName,
                    prefixIcon: Icon(Iconsax.user),
                  ),
                  onFieldSubmitted: (value) {
                    FocusScope.of(context).requestFocus(controller.lNameNode);
                  },
                ),
              ),
              const SizedBox(width: TSizes.spaceBtwInputFields),
              Expanded(
                child: TextFormField(
                  focusNode: controller.lNameNode,
                  controller: controller.lastName,
                  textInputAction: TextInputAction.next,
                  validator: (value) =>
                      TValidator.displayNamevalidator('Last name', value),
                  expands: false,
                  decoration: const InputDecoration(
                      labelText: TTexts.lastName,
                      prefixIcon: Icon(Iconsax.user)),
                  onFieldSubmitted: (value) {
                    FocusScope.of(context).requestFocus(controller.uNameNode);
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: TSizes.spaceBtwInputFields),

          // UserName
          TextFormField(
            focusNode: controller.uNameNode,
            controller: controller.userName,
            expands: false,
            textInputAction: TextInputAction.next,
            validator: (value) =>
                TValidator.displayNamevalidator('Username', value),
            decoration: const InputDecoration(
                labelText: TTexts.userName,
                prefixIcon: Icon(Iconsax.user_edit)),
            onFieldSubmitted: (value) {
              FocusScope.of(context).requestFocus(controller.eEmailNode);
            },
          ),
          const SizedBox(height: TSizes.spaceBtwInputFields),

          // Email
          TextFormField(
            focusNode: controller.eEmailNode,
            controller: controller.email,
            textInputAction: TextInputAction.next,
            validator: (value) => TValidator.emailValidator(value),
            decoration: const InputDecoration(
                labelText: TTexts.email, prefixIcon: Icon(Iconsax.direct)),
            onFieldSubmitted: (value) {
              FocusScope.of(context).requestFocus(controller.pPhoneNumberNode);
            },
          ),
          const SizedBox(height: TSizes.spaceBtwInputFields),

          // Phone Number
          TextFormField(
            focusNode: controller.pPhoneNumberNode,
            controller: controller.phoneNumber,
            textInputAction: TextInputAction.next,
            validator: (value) => TValidator.phoneNumberValidator(value),
            decoration: const InputDecoration(
                labelText: TTexts.phoneNo, prefixIcon: Icon(Iconsax.call)),
            onFieldSubmitted: (value) {
              FocusScope.of(context).requestFocus(controller.pPasswordNode);
            },
          ),
          const SizedBox(height: TSizes.spaceBtwInputFields),

          // Password
          Obx(() {
            return TextFormField(
              focusNode: controller.pPasswordNode,
              controller: controller.password,
              textInputAction: TextInputAction.done,
              validator: (value) => TValidator.passwordValidator(value),
              obscureText: controller.hidePassword.value,
              expands: false,
              decoration: InputDecoration(
                labelText: TTexts.password,
                prefixIcon: const Icon(Iconsax.password_check),
                suffixIcon: IconButton(
                  onPressed: () => controller.hidePassword.value =
                      !controller.hidePassword.value,
                  icon: Icon(controller.hidePassword.value
                      ? Iconsax.eye_slash
                      : Iconsax.eye),
                ),
              ),
              onFieldSubmitted: (value) => FocusScope.of(context).unfocus(),
            );
          }),
          const SizedBox(height: TSizes.spaceBtwScetions),

          // Terms and Condition Check Box
          const TermsAndConditionCheckBox(),
          const SizedBox(height: TSizes.spaceBtwScetions),

          // SignUp Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                FocusScope.of(context).unfocus();
                controller.signUp();
              },
              child: const Text(TTexts.createAccount),
            ),
          ),
        ],
      ),
    );
  }
}
