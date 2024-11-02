import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:t_store/features/authentication/screens/login/login.dart';
import 'package:t_store/features/authentication/screens/onbording/onbording.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get istance => Get.find();

  final deviceStorage = GetStorage();
  final auth = FirebaseAuth.instance;

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

/*..............................Email & Password sign-In..............................*/
  ///... (Email Authentication) - Signin

  ///... (EmaitAuthentication1) - REGISTER
  Future<UserCredential> registerWithEmaitAndPassword(
      {required email, required password}) async {
    try {
      return await auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw FirebaseAuthException(code: e.code);
    } on FirebaseAuth catch (e) {
      throw FirebaseException(plugin: e.toString());
    } on FormatException catch (_) {
      throw const FormatException();
    } on PlatformException catch (e) {
      throw PlatformException(code: e.code);
    } catch (e) {
      throw 'somethinq went wrong. Please try again';
    }
  }

  ///... (Email Authentication) - MAIL VERIFICATION
  ///... (Email Authentication) - ReAuthenticate User
  ///... (Email Authentication) - FORGET PASSWORD

/*..............................Federated identity & social sign-in..............................*/
  ///... (IGoogteAutnenticationl) - GOOGLE
  ///... (FacebookAuthentication) - FACEBOOK

/*............................... ./end Federated identity & social sign-in..............................*/
  ///... (Logoutuser) - Valid for any authentication.
  ///... (Deteteuser) - Remove user Auth and Firestone Account.
}
