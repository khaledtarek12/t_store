import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:t_store/common/widgets/loading/custom_loading.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/helpers/firebase_storage.dart';

class TCloudHelperFunction {
  // Helper function to check the state of a single database record.
  // Returns o Widget based on the state of tne snapshot.
  // If data is still loading, it returns a CircularProgressIndicator.
  // If no data is found, it returns o generic "No Oota Found" message.
  // If an error occurs, it returns o generic error message.
  // Otherwise, it returns null.

  static Widget? checkSingleRecordState<T>(AsyncSnapshot<T> snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return const CustomLoading(loadingColor: TColors.primary);
    }

    if (!snapshot.hasData || snapshot.data == null) {
      return const Center(child: Text('No Data Found!'));
    }

    if (snapshot.hasError) {
      return const Center(child: Text('Some Thing Went Wrong'));
    }
    return null;
  }

  // Helper function to check the state of multiple (list) database records.
  // Returns a Widget based on the state of the snapshot.
  // If dato is stilt loading, it returns a CirculorProqressIndicator
  // If no cata is founa, it returns o generic "No Oota Fount}" message or a custom nothingFounaWiaqet it proviaea.
  // it returns o generic error message.
  // If an error occurs,
  // Otherwise, it returns null.

  static Widget? checkMultiRecordState<T>(
      {required AsyncSnapshot<List<T>> snapshot,
      Widget? loader,
      Widget? error,
      Widget? nothingFound}) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      if (loader != null) return loader;
      return const CustomLoading(loadingColor: TColors.primary);
    }

    if (!snapshot.hasData || snapshot.data == null || snapshot.data!.isEmpty) {
      if (nothingFound != null) return nothingFound;
      return const Center(child: Text('No Data Found!'));
    }

    if (snapshot.hasError) {
      if (error != null) return error;
      return const Center(child: Text('Some Thing Went Wrong'));
    }
    return null;
  }

  /// Create o reference with on initial file path and name and retrieve the download URL
  static Future<String> getURLFromFilePathAndName(String path) async {
    try {
      if (path.isEmpty) return '';
      final storage = await TStorage.getStorageInstance();
      final ref = storage.ref().child(path);
      final url = await ref.getDownloadURL();
      return url;
    } on FirebaseException catch (e) {
      throw e.message!;
    } on PlatformException catch (e) {
      throw e.message!;
    } catch (e) {
      throw 'somethinq went wrong. Please try again: $e';
    }
  }
}
