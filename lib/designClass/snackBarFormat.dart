import 'package:flutter/material.dart';

class SnackBarFormat extends SnackBar {
  SnackBarFormat(Widget contents, BuildContext context, {super.key})
      : super(
          content: contents,
          behavior: SnackBarBehavior.floating,
          elevation: 6.0,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20))),
          width: MediaQuery.of(context).size.width * 0.8,
        );
}

void welcome(context) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBarFormat(
      const Text(
        "welcome!",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          letterSpacing: 1.5,
        ),
        textAlign: TextAlign.center,
      ),
      context,
    ),
  );
}
