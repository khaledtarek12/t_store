import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:t_store/data/repositories/authentication/authentication_repository.dart';
import 'package:t_store/features/personalization/controllers/user_controller.dart';
import 'package:t_store/utils/constants/image_strings.dart';
import 'package:t_store/utils/helpers/network_manager.dart';
import 'package:t_store/utils/popups/full_screen_loader.dart';
import 'package:t_store/utils/popups/loaders.dart';

class LoginController extends GetxController {
  /// variables
  final localStorage = GetStorage();
  final email = TextEditingController();
  final password = TextEditingController();
  final rememberMe = true.obs;
  final hidePassword = true.obs;

  final fEmailNode = FocusNode();
  final fPasswordNode = FocusNode();

  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  final userController = Get.put(UserController());

  @override
  void onInit() {
    log("Initializing LoginController..."); // Debug: Initialization start
    if (localStorage.read('REMEMBER_ME_EMAIL') != null &&
        localStorage.read('REMEMBER_ME_PASSWORD') != null) {
      email.text = localStorage.read('REMEMBER_ME_EMAIL');
      password.text = localStorage.read('REMEMBER_ME_PASSWORD');
      log("Loaded saved credentials from local storage."); // Debug: Loaded credentials
    } else {
      log("No saved credentials found."); // Debug: No credentials in storage
    }
    super.onInit();
  }

  //-- Email ond Password SiqnIn
  Future<void> emailAndPasswordSignin() async {
    try {
      log("Starting emailAndPasswordSignin..."); // Debug: Start of function

      // Start Loading
      TFullScreenLoader.openLoadingDialog(
          'Logging you in....', TImages.loading);
      log("Loading dialog opened."); // Debug: Loader opened

      // Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      log("Internet connection check completed: $isConnected"); // Debug: Internet connectivity result
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        TLoaders.errorSnakBar(
            title: 'Connection Error', message: 'No internet connection.');
        log("No internet connection. Exiting function."); // Debug: No internet
        return;
      }

      // Form Validation
      if (!loginFormKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        TLoaders.errorSnakBar(
            title: 'Invalid Input', message: 'Please fill out all fields.');
        log("Form validation failed."); // Debug: Form validation failed
        return;
      }
      log("Form validation passed."); // Debug: Form validation passed

      // Save Data if Remember Me is selected
      if (rememberMe.value) {
        localStorage.write('REMEMBER_ME_EMAIL', email.text.trim());
        localStorage.write('REMEMBER_ME_PASSWORD', password.text.trim());
        log("Remember Me selected. Credentials saved."); // Debug: Remember Me data saved
      }

      // Attempt login with Firebase Authentication
      log("Attempting login with Firebase..."); // Debug: Starting login attempt
      await AuthenticationRepository.istance.loginWithEmaitAndPassword(
          email: email.text.trim(), password: password.text.trim());
      log("Login successful."); // Debug: Login successful

      // Remove loader and Redirect
      TFullScreenLoader.stopLoading();
      AuthenticationRepository.istance.screenRedirect();
      log("Loader stopped and user redirected."); // Debug: Loader stopped, user redirected
    } catch (e) {
      // Remove loader and show error message
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnakBar(title: 'Oh Snap!', message: e.toString());
      log("Error occurred: $e"); // Debug: Exception caught
    }
  }

  //-- Google Signin Authentication
  Future<void> googleSignIn() async {
    try {
      // Debug: Start of function
      log("Starting GoogleSignin...");

      // Start Loading
      TFullScreenLoader.openLoadingDialog(
          'Logging you in....', TImages.loading);
      log("Loading dialog opened."); // Debug: Loader opened

      // Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      log("Internet connection check completed: $isConnected"); // Debug: Internet connectivity result
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        TLoaders.errorSnakBar(
            title: 'Connection Error', message: 'No internet connection.');
        log("No internet connection. Exiting function."); // Debug: No internet
        return;
      }

      //-- Google Authentication
      final userCredentials =
          await AuthenticationRepository.istance.signInWithGoogle();

      // -- Save User Data
      await userController.saveUserCard(userCredentials);

      // Remove the Loaders
      TFullScreenLoader.stopLoading();

      // Redirect Screens
      AuthenticationRepository.istance.screenRedirect();
    } catch (e) {
      // Remove the Loaders
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnakBar(title: 'Oh Snap!', message: e.toString());
    }
  }
}
