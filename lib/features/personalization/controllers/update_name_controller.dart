import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_store/data/repositories/user/user_repository.dart';
import 'package:t_store/features/personalization/controllers/user_controller.dart';
import 'package:t_store/utils/constants/image_strings.dart';
import 'package:t_store/utils/helpers/network_manager.dart';
import 'package:t_store/utils/popups/full_screen_loader.dart';
import 'package:t_store/utils/popups/loaders.dart';

class UpdateNameController extends GetxController {
  static UpdateNameController get instance => Get.find();

  final firstName = TextEditingController();
  final lastName = TextEditingController();

  final firstNameNode = FocusNode();
  final lastNameNode = FocusNode();

  final userController = UserController.instance;
  final userRepository = Get.put(UserRepository());

  GlobalKey<FormState> udateUserNameFormKey = GlobalKey<FormState>();

  @override
  void onInit() {
    initializeNames();
    super.onInit();
  }

  Future<void> initializeNames() async {
    firstName.text = userController.user.value.firstName;
    lastName.text = userController.user.value.lastName;
  }

  Future<void> updateUserName() async {
    try {
      TFullScreenLoader.openLoadingDialog(
          'We are updating your information...', TImages.loading);

      // Check internet
      final isConnected = await NetworkManager.instance.isConnected();
      log("Internet connection check completed: $isConnected"); // Debug: Internet connectivity result
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        TLoaders.errorSnakBar(
            title: 'Connection Error', message: 'No internet connection.');
        log("No internet connection. Exiting function."); // Debug: No internet
        return;
      }

      Map<String, dynamic> name = {
        'FirstName': firstName.text.trim(),
        'LastName': firstName.text.trim(),
      };

      await userRepository.updateSingleField(name);

      // Update the Rx User value
      userController.user.value.firstName = firstName.text.trim();
      userController.user.value.lastName = lastName.text.trim();

      // Remove Loaders
      TFullScreenLoader.stopLoading();

      // Show Success Message
      TLoaders.successSnakBar(
          title: 'Congratulations', message: 'Your Name has been updated.');

      // Move back to previus Screen
      Get.back();
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnakBar(title: 'Oh Snap!', message: e.toString());
    }
  }
}
