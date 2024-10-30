import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProgressController extends GetxController with GetSingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> animation;
  final RxDouble animatedValue = 0.0.obs;
  final double targetValue;

  ProgressController({required this.targetValue});

  @override
  void onInit() {
    super.onInit();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2), // Animation duration
    );

    // Tween animation from 0.0 to targetValue
    animation = Tween<double>(begin: 0.0, end: targetValue).animate(
      CurvedAnimation(parent: animationController, curve: Curves.easeOut),
    )..addListener(() {
        animatedValue.value = animation.value; // Update animated value
      });

    animationController.forward(); // Start the animation
  }

  @override
  void onClose() {
    animationController.dispose();
    super.onClose();
  }
}
