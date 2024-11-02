import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:t_store/features/authentication/models/user_model.module.dart';

// Repository Closs for user-related operations.
class UserRepository extends GetxController {
  static UserRepository get instance => Get.find();

  final FirebaseFirestore dataBase = FirebaseFirestore.instance;

  // Function to sove user data to Firestore.
  Future<void> saveUserCard(UserModel user) async {
    try {
      return await dataBase.collection("Users").doc(user.id).set(user.toJson());
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
}
