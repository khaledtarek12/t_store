import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:t_store/data/repositories/authentication/authentication_repository.dart';
import 'package:t_store/features/personalization/models/address_model.module.dart';
import 'package:t_store/utils/exceptions/firebase_exception.dart';
import 'package:t_store/utils/exceptions/platform_exception.dart';

class AddressRepositry extends GetxController {
  static AddressRepositry get instance => Get.find();

  final dataBase = FirebaseFirestore.instance;

  // Get all Address
  Future<List<AddressModel>> fetchUserAddress() async {
    try {
      final userId = AuthenticationRepository.instance.authUser!.uid;

      if (userId.isEmpty) {
        throw 'Unabe to find User information. try again later';
      }

      final result = await dataBase
          .collection('Users')
          .doc(userId)
          .collection('Addresses')
          .get();

      return result.docs
          .map((e) => AddressModel.fromDocumentSnapshot(e))
          .toList();
    } on FirebaseException catch (e) {
      throw TFirebaseException(code: e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(code: e.code).message;
    } catch (e) {
      throw 'somethinq went wrong while fetching Address information. Try again later';
    }
  }

  Future<void> updateSelectedField(String addressId, bool selected) async {
    try {
      final userId = AuthenticationRepository.instance.authUser!.uid;
      if (userId.isEmpty) {
        throw 'Unabe to find User information. try again later';
      }
      await dataBase
          .collection('Users')
          .doc(userId)
          .collection('Addresses')
          .doc(addressId)
          .update({'SelectedAddress': selected});
    } catch (e) {
      throw 'unable to update your address selection. Try again later';
    }
  }

  Future<String> addAddress(AddressModel address) async {
    try {
      final userId = AuthenticationRepository.instance.authUser!.uid;
      final currentAddress = await dataBase
          .collection('Users')
          .doc(userId)
          .collection('Addresses')
          .add(address.toJson());

      return currentAddress.id;
    } catch (e) {
      throw 'Something went wrong while saving Address Information. Try again later ';
    }
  }
}
