import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:t_store/data/repositories/authentication/authentication_repository.dart';
import 'package:t_store/utils/constants/image_strings.dart';
import 'package:t_store/utils/helpers/network_manager.dart';
import 'package:t_store/utils/popups/full_screen_loader.dart';
import 'package:t_store/utils/popups/loaders.dart';

class LoginController extends GetxController {
  /// variables
  final localStorage = GetStorage();
  final email = TextEditingController();
  final password = TextEditingController();
  final rememberMe = false.obs;
  final hidePassword = true.obs;

  final fEmailNode = FocusNode();
  final fPasswordNode = FocusNode();

  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

  @override
  void onInit() {
    // if (email.text != null && password.text != null) {
    //   email.text = localStorage.read('REMEMBER_ME_EMAIL');
    //   password.text = localStorage.read('REMEMBER_ME_PASSWORD');
    // } else {
    //   return;
    // }
    super.onInit();
  }

  Future<void> emailAndPasswordSignin() async {
    try {
      // Start Loading
      TFullScreenLoader.openLoadingDialog(
          'Logging you in....', TImages.loading);

      // Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }

      // Form Validation
      if (!loginFormKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }

      // Save Data if Remember Me  is selected
      if (rememberMe.value) {
        localStorage.write('REMEMBER_ME_EMAIL', email.text.trim());
        localStorage.write('REMEMBER_ME_PASSWORD', password.text.trim());
        return;
      }

      // Reqistpr user in the Firebase Authentication Save user data in the Firebase
      await AuthenticationRepository.istance.loginWithEmaitAndPassword(
          email: email.text.trim(), password: password.text.trim());

      // remove loader
      TFullScreenLoader.stopLoading();

      // Redirect
      AuthenticationRepository.istance.screenRedirect();

      /*......................................................*/
    } catch (e) {
      // remove loader
      TFullScreenLoader.stopLoading();

      // show some Generic Error to the user
      TLoaders.errorSnakBar(title: 'Oh Snap!', message: e.toString());
    }
  }
}
