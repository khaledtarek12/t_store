import 'package:get/get.dart';

class HomeController extends GetxController {
  static HomeController get instance => Get.find();

  final carsoualCurrentIndex = 0.obs;

  void updatePageIndicator(index) {
    carsoualCurrentIndex.value = index;
    
  }
}
