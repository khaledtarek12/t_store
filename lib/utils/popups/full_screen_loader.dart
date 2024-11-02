import 'dart:ui'; // Import for the Blur effect
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_store/common/widgets/loading/animation_loader.dart';

class TFullScreenLoader {
  static void openLoadingDialog(String text, String animation) {
    showDialog(
      context: Get.overlayContext!,
      barrierDismissible: false,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0), // Rounded corners
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12.0),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
            child: Container(
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomCenter,
                    colors: [Colors.white60, Colors.white10]),
                borderRadius: BorderRadius.circular(12.0), // Rounded corners
                border: Border.all(
                    color: Colors.white30,
                    width: 1), // Light border for the glass effect
              ),
              width: 300, // Set the width of the dialog
              height: MediaQuery.of(context).size.height * 0.5,
              child: Center(
                child:
                    TAnimationLoaderWidgets(text: text, animation: animation),
              ),
            ),
          ),
        ),
      ),
    );
  }

  static void stopLoading() {
    Navigator.of(Get.overlayContext!).pop();
  }
}
