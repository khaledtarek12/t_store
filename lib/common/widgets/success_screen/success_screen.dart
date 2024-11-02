import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:t_store/common/styles/spacing_styles.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/constants/text_strings.dart';
import 'package:t_store/utils/helpers/helper_function.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen(
      {super.key,
      required this.image,
      required this.title,
      required this.subTitle,
      required this.onPressed,
      this.isIamge = true});

  final String image, title, subTitle;
  final VoidCallback onPressed;
  final bool? isIamge;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: TSpacingStyles.paddingWithAppbarHeiht * 2,
          child: Column(
            children: [
              // images
              isIamge!
                  ? Image.asset(image,
                      width: THelperFunction.screenWidth() * 0.6)
                  : Lottie.asset(
                      image, // Path to your Lottie file
                      width: THelperFunction.screenWidth(),
                      fit: BoxFit.contain, // Adjust fit as needed
                    ),
              const SizedBox(height: TSizes.spaceBtwScetions),

              // title and subtitle
              Text(title,
                  style: Theme.of(context).textTheme.headlineMedium,
                  textAlign: TextAlign.center),
              const SizedBox(height: TSizes.spaceBtwItems),

              Text(subTitle,
                  style: Theme.of(context).textTheme.labelMedium,
                  textAlign: TextAlign.center),
              const SizedBox(height: TSizes.spaceBtwScetions),

              // buttons
              SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: onPressed,
                      child: const Text(TTexts.tcontinue))),
              const SizedBox(height: TSizes.spaceBtwItems),
            ],
          ),
        ),
      ),
    );
  }
}
