import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store/common/widgets/appbar/custom_appbar.dart';
import 'package:t_store/features/personalization/controllers/update_name_controller.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/constants/text_strings.dart';
import 'package:t_store/utils/validators/validation.dart';

class ChangeNameScreen extends StatelessWidget {
  const ChangeNameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UpdateNameController());
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: TAppbar(
          showBackArrow: true,
          title: Text('Change Name',
              style: Theme.of(context).textTheme.headlineSmall),
        ),
        body: Padding(
          padding: const EdgeInsets.all(TSizes.defultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Heading
              Text(
                'Use real name for easy verification. This name will appear on several pages',
                style: Theme.of(context)
                    .textTheme
                    .labelLarge!
                    .apply(color: TColors.darkGrey),
              ),
              const SizedBox(height: TSizes.spaceBtwScetions),

              // Textfield and Buttons
              Form(
                  key: controller.udateUserNameFormKey,
                  child: Column(
                    children: [
                      TextFormField(
                        expands: false,
                        focusNode: controller.firstNameNode,
                        controller: controller.firstName,
                        textInputAction: TextInputAction.next,
                        validator: (value) => TValidator.displayNamevalidator(
                            'First name', value),
                        onFieldSubmitted: (value) => FocusScope.of(context)
                            .requestFocus(controller.lastNameNode),
                        decoration: const InputDecoration(
                            prefixIcon: Icon(Iconsax.user),
                            labelText: TTexts.fristName),
                      ),
                      const SizedBox(height: TSizes.spaceBtwInputFields),
                      TextFormField(
                        expands: false,
                        focusNode: controller.lastNameNode,
                        controller: controller.lastName,
                        textInputAction: TextInputAction.done,
                        onFieldSubmitted: (value) =>
                            FocusScope.of(context).unfocus(),
                        validator: (value) =>
                            TValidator.displayNamevalidator('Last name', value),
                        decoration: const InputDecoration(
                            prefixIcon: Icon(Iconsax.user),
                            labelText: TTexts.lastName),
                      ),
                    ],
                  )),
              const SizedBox(height: TSizes.spaceBtwScetions),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () => controller.updateUserName(),
                    child: const Text('Save')),
              )
            ],
          ),
        ),
      ),
    );
  }
}
