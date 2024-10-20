import 'package:flutter/material.dart';
import 'package:t_store/common/styles/spacing_styles.dart';
import 'package:t_store/features/screens/login/widgets/divider_form.dart';
import 'package:t_store/features/screens/login/widgets/login_form_page.dart';
import 'package:t_store/features/screens/login/widgets/login_header.dart';
import 'package:t_store/features/screens/login/widgets/socail_button_form.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/helpers/helper_function.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunction.isDarkMode(context);
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: TSpacingStyles.paddingWithAppbarHeiht,
            child: Column(
              children: [
                //Logo , Title and Subtitle
                TLoginHeader(dark: dark),
                const SizedBox(height: TSizes.spaceBtwScetions),
                //Form
                const LoginFormPage(),
                //Divider
                TFormDivider(dark: dark),
                const SizedBox(height: TSizes.spaceBtwItems),
                //Footer
                const TFormSocialButtons()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
