import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:t_store/data/repositories/authentication/authentication_repository.dart';
import 'package:t_store/features/shop/models/order_model.module.dart';

class OrderRepositry extends GetxController {
  static OrderRepositry get instance => Get.find();

  final dataBase = FirebaseFirestore.instance;

/* ------------------------  FUNCTIONS ------------------------ */
  /// Get order ret at pd to current User
  Future<List<OrderModel>> fetchUserOrders() async {
    try {
      final userId = AuthenticationRepository.instance.authUser?.uid;
      if (userId!.isEmpty) {
        throw 'Unable to find user information. Try again in few minutes.';
      }

      final result = await dataBase
          .collection('Users')
          .doc(userId)
          .collection('Orders')
          .get();

      return result.docs
          .map((documentSnapshot) => OrderModel.fromSnapshot(documentSnapshot))
          .toList();
    } catch (e) {
      log(e.toString());
      throw 'Something went arong while fetching Order Information. Try again later';
    }
  }

  /// Store new user order
  Future<void> saveOrder(OrderModel order, String userId) async {
    try {
      await dataBase
          .collection('Users')
          .doc(userId)
          .collection('Orders')
          .add(order.toJson());
    } catch (e) {
      throw 'Something went arong while Saving Order Information. Try again later';
    }
  }
}
