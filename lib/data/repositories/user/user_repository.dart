import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:t_store/data/repositories/authentication/authentication_repository.dart';
import 'package:t_store/features/authentication/models/user_model.module.dart';
import 'package:t_store/utils/exceptions/firebase_auth_exception.dart';
import 'package:t_store/utils/exceptions/firebase_exception.dart';
import 'package:t_store/utils/exceptions/format_exception.dart';
import 'package:t_store/utils/exceptions/platform_exception.dart';
import 'package:t_store/utils/helpers/firebase_storage.dart';

// Repository Closs for user-related operations.
class UserRepository extends GetxController {
  static UserRepository get instance => Get.find();

  final FirebaseFirestore dataBase = FirebaseFirestore.instance;

  // Function to sove user data to Firestore.
  Future<void> saveUserCard(UserModel user) async {
    try {
      return await dataBase.collection("Users").doc(user.id).set(user.toJson());
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(code: e.code).message;
    } on FirebaseException catch (e) {
      throw TFirebaseException(code: e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(code: e.code).message;
    } catch (e) {
      throw 'somethinq went wrong. Please try again';
    }
  }

  // Function to fetch user details based on user ID.
  Future<UserModel> fetchUserDetails() async {
    try {
      final documentSnapshot = await dataBase
          .collection("Users")
          .doc(AuthenticationRepository.istance.authUser?.uid)
          .get();

      if (documentSnapshot.exists) {
        return UserModel.fromSnapShot(documentSnapshot);
      } else {
        return UserModel.empty();
      }
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(code: e.code).message;
    } on FirebaseException catch (e) {
      throw TFirebaseException(code: e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(code: e.code).message;
    } catch (e) {
      throw 'somethinq went wrong. Please try again';
    }
  }

  // Function to update user data in firestore.
  Future<void> updateUserDetails(UserModel updatedUser) async {
    try {
      await dataBase
          .collection("Users")
          .doc(updatedUser.id)
          .update(updatedUser.toJson());
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(code: e.code).message;
    } on FirebaseException catch (e) {
      throw TFirebaseException(code: e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(code: e.code).message;
    } catch (e) {
      throw 'somethinq went wrong. Please try again';
    }
  }

  // Update any field in specific Users Collection
  Future<void> updateSingleField(Map<String, dynamic> json) async {
    try {
      await dataBase
          .collection("Users")
          .doc(AuthenticationRepository.istance.authUser?.uid)
          .update(json);
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(code: e.code).message;
    } on FirebaseException catch (e) {
      throw TFirebaseException(code: e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(code: e.code).message;
    } catch (e) {
      throw 'somethinq went wrong. Please try again';
    }
  }

  // Function to remove user data from Fires tore.
  Future<void> removeUserRecord(String userId) async {
    try {
      await dataBase.collection("Users").doc(userId).delete();
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(code: e.code).message;
    } on FirebaseException catch (e) {
      throw TFirebaseException(code: e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(code: e.code).message;
    } catch (e) {
      throw 'somethinq went wrong. Please try again';
    }
  }

  // Upload any Imagge
  Future<String> uploadImagge(String path, XFile image) async {
    try {
      final storage = await TStorage.getStorageInstance();
      final ref = storage.ref(path).child(image.name);
      await ref.putFile(File(image.path));
      final url = await ref.getDownloadURL();

      return url;
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(code: e.code).message;
    } on FirebaseException catch (e) {
      throw TFirebaseException(code: e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(code: e.code).message;
    } catch (e) {
      throw 'somethinq went wrong. Please try again';
    }
  }
}
