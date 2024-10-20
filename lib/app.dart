import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:t_store/features/screens/onbording/onbording.dart';
import 'package:t_store/utils/theme/theme.dart';

class TStoreApp extends StatelessWidget {
  const TStoreApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: TAppTheme.lightTheme,
      darkTheme: TAppTheme.darkTheme,
      home: const OnbordingScreen(),
    );
  }
}
