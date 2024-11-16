import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_store/data/repositories/authentication/authentication_repository.dart';
import 'package:t_store/features/authentication/screens/password_configration/reset_password.dart';
import 'package:t_store/utils/constants/image_strings.dart';
import 'package:t_store/utils/helpers/network_manager.dart';
import 'package:t_store/utils/popups/full_screen_loader.dart';
import 'package:t_store/utils/popups/loaders.dart';

class ForgetPasswordController extends GetxController {
  static ForgetPasswordController get instance => Get.find();

  final email = TextEditingController();
  GlobalKey<FormState> forgetPasswordFormKey = GlobalKey<FormState>();

  // Send Reset Password Email
  sendPasswordResetEmail() async {
    try {
      // Debug: Start of function
      log("Starting Send Password Reset Email ...");

      // Start Loading
      TFullScreenLoader.openLoadingDialog(
          'Logging you in....', TImages.loading);
      log("Loading dialog opened.");

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
      if (!forgetPasswordFormKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        TLoaders.errorSnakBar(
            title: 'Invalid Input', message: 'Please fill out all fields.');
        log("Form validation failed."); // Debug: Form validation failed
        return;
      }
      log("Form validation passed."); // Debug: Form validation passed

      // Debug: Starting login attempt
      log("Attempting login with Firebase...");
      await AuthenticationRepository.instance
          .sendPasswordResetEmail(email: email.text.trim());
      log("Send Email successfully."); // Debug: Login successful

      TFullScreenLoader.stopLoading();

      TLoaders.successSnakBar(
          title: 'Email Sent',
          message: 'Email Link Sent to Reset your Password'.tr);
      Get.to(() => ResetPasswordScreen(email: email.text.trim()));
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnakBar(title: 'Oh Snap!', message: e.toString());
      log("Error occurred: $e"); // Debug: Exception caught
    }
  }

  reSendPasswordResetEmail(String email) async {
    try {
      // Debug: Start of function
      log("Starting Send Password Reset Email ...");

      // Start Loading
      TFullScreenLoader.openLoadingDialog(
          'Logging you in....', TImages.loading);
      log("Loading dialog opened.");

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

      // Debug: Starting login attempt
      log("Attempting login with Firebase...");
      await AuthenticationRepository.instance
          .sendPasswordResetEmail(email: email);
      log("Send Email successfully."); // Debug: Login successful

      TFullScreenLoader.stopLoading();

      TLoaders.successSnakBar(
          title: 'Email Sent',
          message: 'Email Link Sent to Reset your Password'.tr);
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnakBar(title: 'Oh Snap!', message: e.toString());
      log("Error occurred: $e"); // Debug: Exception caught
    }
  }
}
