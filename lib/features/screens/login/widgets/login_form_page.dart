import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/constants/text_strings.dart';
import 'package:t_store/utils/helpers/helper_function.dart';

class LoginFormPage extends StatelessWidget {
  const LoginFormPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunction.isDarkMode(context);
    return Form(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: TSizes.spaceBtwScetions),
        child: Column(
          children: [
            //Email
            TextFormField(
              decoration: const InputDecoration(
                  prefixIcon: Icon(Iconsax.direct_right),
                  labelText: TTexts.email),
            ),

            const SizedBox(height: TSizes.spaceBtwInputFields),

            //Email
            TextFormField(
              decoration: const InputDecoration(
                prefixIcon: Icon(Iconsax.password_check),
                labelText: TTexts.password,
                suffixIcon: Icon(Iconsax.eye_slash),
              ),
            ),
            const SizedBox(height: TSizes.spaceBtwInputFields / 2),

            //Remeber me and forrget password
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //Remeber me
                Row(
                  children: [
                    Checkbox(value: true, onChanged: (value) {}),
                    const Text(TTexts.rememberMe),
                  ],
                ),

                //Forrget password
                TextButton(
                    onPressed: () {},
                    child: const Text(TTexts.forrgetPassword)),
              ],
            ),
            const SizedBox(height: TSizes.spaceBtwScetions),

            //Sign in button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: () {}, child: const Text(TTexts.signIn)),
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
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
