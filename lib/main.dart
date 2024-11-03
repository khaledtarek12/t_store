// ignore_for_file: unused_local_variable
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:t_store/app.dart';
import 'package:t_store/data/repositories/authentication/authentication_repository.dart';
import 'package:t_store/firebase_options.dart';

void main() async {
  //...FireBase
  final WidgetsBinding widgetsBinding =
      WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform)
      .then(
    (FirebaseApp value) {
      Get.put(AuthenticationRepository());
    },
  );

  //...Get Storage
  await GetStorage.init();

  //...Await Sptlash until otner items Load
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  runApp(const TStoreApp());
}
