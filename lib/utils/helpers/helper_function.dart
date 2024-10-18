import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class THelperFunction {
  THelperFunction._();

  static Color? getColor({required String value}) {
    if (value == 'Green') {
      return Colors.green;
    } else if (value == 'Red') {
      return Colors.red;
    } else if (value == 'Blue') {
      return Colors.blue;
    } else if (value == 'Pink') {
      return Colors.pink;
    } else if (value == 'Gery') {
      return Colors.grey;
    } else if (value == 'Purple') {
      return Colors.purple;
    } else if (value == 'Black') {
      return Colors.black;
    } else if (value == 'White') {
      return Colors.white;
    } else if (value == 'Brown') {
      return Colors.brown;
    } else if (value == 'Teal') {
      return Colors.teal;
    } else if (value == 'Indigo') {
      return Colors.indigo;
    } else {
      return null;
    }
  }

  static void showSnackBar({required String message}) {
    ScaffoldMessenger.of(Get.context!)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  static void showAlert({required String message, required String title}) {
    showDialog(
      context: Get.context!,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop,
              child: const Text('ok'),
            ),
          ],
        );
      },
    );
  }

  static void navigateToScreen(
      {required BuildContext context, required Widget screen}) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => screen,
        ));
  }

  static String truncateText({required String text, required int maxLength}) {
    if (text.length <= maxLength) {
      return text;
    } else {
      return '${text.substring(0, maxLength)}...';
    }
  }

  static bool isDarkMode(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }

  static Size screenSize() {
    return MediaQuery.of(Get.context!).size;
  }

  static double screenHeight() {
    return MediaQuery.of(Get.context!).size.height;
  }

  static double screenWidth() {
    return MediaQuery.of(Get.context!).size.width;
  }

  static String getFormatedDate(DateTime date,
      {String format = 'dd-MMM-yyyy'}) {
    return DateFormat(format).format(date);
  }

  static List<T> removeDublicate<T>(List<T> list) {
    return list.toSet().toList();
  }

  static List<Widget> wrapWidgets(
      {required List<Widget> widgets, required int rowSize}) {
    final wrapperList = <Widget>[];
    for (var i = 0; i < widgets.length; i += rowSize) {
      final rowChildern = widgets.sublist(
          i, i + rowSize > widgets.length ? widgets.length : i + rowSize);
      wrapperList.add(Row(
        children: rowChildern,
      ));
    }
    return wrapperList;
  }
}
