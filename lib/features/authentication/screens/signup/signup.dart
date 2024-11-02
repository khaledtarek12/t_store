import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_store/common/widgets/login_signup/divider_form.dart';
import 'package:t_store/common/widgets/login_signup/socail_buttons.dart';
import 'package:t_store/features/authentication/screens/signup/widgets/signup_form.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/constants/text_strings.dart';
import 'package:t_store/utils/helpers/helper_function.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunction.isDarkMode(context);
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () => Get.back(),
              icon: Icon(
                CupertinoIcons.left_chevron,
                color: dark ? TColors.light : TColors.black,
              )),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(TSizes.defultSpace),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title
                Text(TTexts.signUpTitle,
                    style: Theme.of(context).textTheme.headlineMedium),
                const SizedBox(height: TSizes.spaceBtwScetions),
                // Form
                const SingUpFormPage(),
                const SizedBox(height: TSizes.spaceBtwScetions),
                // Divider
                TFormDivider(
                    dark: dark, dividerText: TTexts.orSignUpWith.capitalize!),
                const SizedBox(height: TSizes.spaceBtwScetions),
                //social buttons
                const TSocialButtons()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
