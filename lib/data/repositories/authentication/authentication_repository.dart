import 'package:flutter/foundation.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:t_store/features/authentication/screens/login/login.dart';
import 'package:t_store/features/authentication/screens/onbording/onbording.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get istance => Get.find();

  final deviceStorage = GetStorage();

  @override
  void onReady() {
    FlutterNativeSplash.remove();
    screenRedirect();
    super.onReady();
  }

  //.......Fuction Show Relevant Screen
  screenRedirect() async {
    // Local Storage
    if (kDebugMode) {
      print('====================Get Storage Auth Repo====================');
      print(deviceStorage.read('isFirstTime'));
    }

    deviceStorage.writeIfNull('isFirstTime', true);
    deviceStorage.read('isFirstTime') != true
        ? Get.offAll(() => const LoginScreen())
        : Get.offAll(() => const OnbordingScreen());
  }
}
