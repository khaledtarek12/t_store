import 'package:flutter/material.dart';

class TCustomCurviedEdges extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height);

    final fristCurved = Offset(0, size.height - 20);
    final lastCurved = Offset(30, size.height - 20);
    path.quadraticBezierTo(
        fristCurved.dx, fristCurved.dy, lastCurved.dx, lastCurved.dy);

    final secondFristCurved = Offset(0, size.height - 20);
    final secondLastCurved = Offset(size.width - 30, size.height - 20);
    path.quadraticBezierTo(secondFristCurved.dx, secondFristCurved.dy,
        secondLastCurved.dx, secondLastCurved.dy);

    final thirdFristCurved = Offset(size.width, size.height - 20);
    final thirdLastCurved = Offset(size.width, size.height);
    path.quadraticBezierTo(thirdFristCurved.dx, thirdFristCurved.dy,
        thirdLastCurved.dx, thirdLastCurved.dy);

    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
