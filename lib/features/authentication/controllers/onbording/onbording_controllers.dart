import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:t_store/features/authentication/screens/login/login.dart';

class OnBordingControllers extends GetxController {
  static OnBordingControllers get instance => Get.find();

  //variables
  final pageController = PageController();
  Rx<int> currentPageIndex = 0.obs;
  final storage = GetStorage();

  //update current index when scroll
  void updatePageIndicator(index) => currentPageIndex.value = index;

  //jump to specafic dotted page
  void dotNavigationClick(index) {
    currentPageIndex.value = index;
    pageController.jumpTo(index);
  }

  //update current index & jump to the next page
  void nextPage() {
    if (currentPageIndex.value == 2) {
      if (kDebugMode) {
        print('====================Get Storage Next Button====================');
        print(storage.read('isFirstTime'));
      }

      storage.write('isFirstTime', false);
      Get.offAll(() => const LoginScreen());
    } else {
      int page = currentPageIndex.value + 1;
      pageController.jumpToPage(page);
    }
  }

  //update current index & jump to the last page
  void skipPage() {
    currentPageIndex.value = 2;
    pageController.jumpToPage(2);
  }
}
