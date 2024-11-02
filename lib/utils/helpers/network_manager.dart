// ignore_for_file: unrelated_type_equality_checks

import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:t_store/utils/popups/loaders.dart';

/// Manages the network connectivity status and provides methods to check and handle connectivity changes.
class NetworkManager extends GetxController {
  static NetworkManager get instance => Get.find();

  final Connectivity connectivity = Connectivity();
  late StreamSubscription<List<ConnectivityResult>> connectivitySubscription;

  // Observable list to store connectivity results
  final RxList<ConnectivityResult> connectionStatus =
      [ConnectivityResult.none].obs;

  /// Initialize the network manager and set up a stream to continually check the connection status.
  @override
  void onInit() {
    super.onInit();
    connectivitySubscription =
        connectivity.onConnectivityChanged.listen(updateConnectionStatus);
  }

  /// Update the connection status based on changes in connectivity and show a relevant popup for no internet connection.
  Future<void> updateConnectionStatus(List<ConnectivityResult> result) async {
    connectionStatus.addAll(result);
    if (result.isNotEmpty && result.last == ConnectivityResult.none) {
      TLoaders.warningSnakBar(title: 'No Internet Connection');
    }
  }

  /// Check the internet connection status
  /// Returns 'true' if connected, 'false' otherwise.
  Future<bool> isConnected() async {
    try {
      final result = await connectivity.checkConnectivity();
      return result != ConnectivityResult.none;
    } on PlatformException catch (_) {
      return false;
    }
  }

  /// Dispose or close the active connectivity stream.
  @override
  void onClose() {
    connectivitySubscription.cancel();
    super.onClose();
  }
}
