import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_store/data/repositories/authentication/authentication_repository.dart';
import 'package:t_store/data/repositories/user/user_repository.dart';
import 'package:t_store/features/authentication/models/user_model.module.dart';
import 'package:t_store/features/authentication/screens/signup/verify_email.dart';
import 'package:t_store/utils/constants/image_strings.dart';
import 'package:t_store/utils/helpers/network_manager.dart';
import 'package:t_store/utils/popups/full_screen_loader.dart';
import 'package:t_store/utils/popups/loaders.dart';

class SignupController extends GetxController {
  static SignupController get instance => Get.find();

  //...Varidbles
  final hidePassword = true.obs;
  final privacyPolicy = true.obs;
  final fristName = TextEditingController();
  final lastName = TextEditingController();
  final userName = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  final phoneNumber = TextEditingController();

  final fNameNode = FocusNode();
  final lNameNode = FocusNode();
  final uNameNode = FocusNode();
  final eEmailNode = FocusNode();
  final pPasswordNode = FocusNode();
  final pPhoneNumberNode = FocusNode();

  GlobalKey<FormState> signUpFormKey = GlobalKey<FormState>();

  //...SignUp Functions

  Future<void> signUp() async {
    try {
      // Start Loading
      TFullScreenLoader.openLoadingDialog(
          'We are processing your information...', TImages.loading);

      // Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }

      // Form Validation
      if (!signUpFormKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }

      // Privacy Policy Check
      if (!privacyPolicy.value) {
        TLoaders.warningSnakBar(
          title: 'Accept Privacy Policy',
          message:
              'In order to create account, you must have to read and accept the Privacy Policy & Terms Of Use.',
        );
        TFullScreenLoader.stopLoading();
        return;
      }

      // Reqistpr user in the Firebase Authentication Save user data in the Firebase
      final userCredentail = await AuthenticationRepository.istance
          .registerWithEmaitAndPassword(
              email: email.text.trim(), password: password.text.trim());

      // Save Authenticated user data in the Firebase Firestore
      final newUser = UserModel(
        id: userCredentail.user!.uid,
        firstName: fristName.text.trim(),
        lastName: lastName.text.trim(),
        userName: userName.text.trim(),
        email: email.text.trim(),
        phoneNumber: phoneNumber.text.trim(),
        profilePicture: '',
      );

      final userRepository = Get.put(UserRepository());
      await userRepository.saveUserCard(newUser);

      // remove loader
      TFullScreenLoader.stopLoading();

      // Move to Verify Email Screen
      Get.to(() => VerifyEmailScreen(email: email.text.trim()));

      // Show Success Message
      TLoaders.successSnakBar(
        title: 'Congratulations',
        message: 'Your account has been created! Verify email to continue.',
      );

      /*......................................................*/
    } catch (e) {
      // remove loader
      TFullScreenLoader.stopLoading();

      // show some Generic Error to the user
      TLoaders.errorSnakBar(title: 'Oh Snap!', message: e.toString());
    }
  }
}
