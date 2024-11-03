import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store/common/widgets/appbar/custom_appbar.dart';
import 'package:t_store/features/personalization/controllers/user_controller.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/constants/text_strings.dart';
import 'package:t_store/utils/validators/validation.dart';

class ReAuthLoginForm extends StatelessWidget {
  const ReAuthLoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    return Scaffold(
      appBar: const TAppbar(
          showBackArrow: true,
          title: Text(
            'Re-Authenticate User',
          )),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defultSpace),
          child: Form(
            key: controller.reAuthFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Email
                TextFormField(
                  expands: false,
                  focusNode: controller.verifyEmailNode,
                  controller: controller.verifyEmail,
                  textInputAction: TextInputAction.next,
                  validator: (value) => TValidator.emailValidator(value),
                  onFieldSubmitted: (value) => FocusScope.of(context)
                      .requestFocus(controller.verifyPasswordNode),
                  decoration: const InputDecoration(
                      prefixIcon: Icon(Iconsax.direct_right),
                      labelText: TTexts.email),
                ),
                const SizedBox(height: TSizes.spaceBtwInputFields),

                // Password
                Obx(() {
                  return TextFormField(
                    expands: false,
                    obscureText: controller.hidePassword.value,
                    focusNode: controller.verifyPasswordNode,
                    controller: controller.verifyPassword,
                    textInputAction: TextInputAction.done,
                    validator: (value) =>
                        TValidator.displayNamevalidator('Password', value),
                    onFieldSubmitted: (value) =>
                        FocusScope.of(context).unfocus(),
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Iconsax.password_check),
                      labelText: TTexts.password,
                      suffixIcon: IconButton(
                          onPressed: () {
                            controller.hidePassword.value =
                                !controller.hidePassword.value;
                          },
                          icon: Icon(controller.hidePassword.value
                              ? Iconsax.eye_slash
                              : Iconsax.eye)),
                    ),
                  );
                }),

                const SizedBox(height: TSizes.spaceBtwScetions),

                // Login Buttons
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () {
                        controller.reAuthenticateEmailAndPasswordUser();
                      },
                      child: const Text('Verify')),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
