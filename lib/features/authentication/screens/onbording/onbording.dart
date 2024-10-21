import 'package:flutter/material.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:t_store/features/authentication/controllers/onBording/onBording_controllers.dart';
import 'package:t_store/features/authentication/screens/onbording/widgets/onboarding_dot_navigation.dart';
import 'package:t_store/features/authentication/screens/onbording/widgets/onboarding_skip.dart';
import 'package:t_store/utils/constants/image_strings.dart';
import 'package:t_store/utils/constants/text_strings.dart';
import 'widgets/onboarding_next_button.dart';
import 'widgets/onboarding_page.dart';

class OnbordingScreen extends StatelessWidget {
  const OnbordingScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OnBordingControllers());
    return Scaffold(
      body: Stack(
        children: [
          //Horizontal Scrollable Pages
          PageView(
              controller: controller.pageController,
              onPageChanged: controller.updatePageIndicator,
              children: const [
                OnBoerdingPage(
                  image: TImages.onboardingImage1,
                  title: TTexts.onBoardingTitle1,
                  subTitle: TTexts.onBoardingSubTitle1,
                ),
                OnBoerdingPage(
                  image: TImages.onboardingImage2,
                  title: TTexts.onBoardingTitle2,
                  subTitle: TTexts.onBoardingSubTitle2,
                ),
                OnBoerdingPage(
                  image: TImages.onboardingImage3,
                  title: TTexts.onBoardingTitle3,
                  subTitle: TTexts.onBoardingSubTitle3,
                ),
              ]),

          //skip button
          const OnBordingSkip(),

          //Dot navigation smooth Indicator
          const OnBordingDotNavigation(),

          //Circular Button
          const OnBordingNextButton()
        ],
      ),
    );
  }
}
