import 'package:flutter/material.dart';

class CustomSnackBar {
  final String message;
  final String action;

  const CustomSnackBar({
    required this.message,
    required this.action,
  });

  static show(
    BuildContext context,
    String message,
    String action,
  ) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        elevation: 0.0,
        behavior: SnackBarBehavior.floating,
        content: Text(message),
        duration: const Duration(milliseconds: 3000),
        backgroundColor: Colors.black87,
        action: SnackBarAction(
          label: action,
          onPressed: () {
            hide(context, message, 'Ok');
          },
        ),
      ),
    );
  }

  static hide(
    BuildContext context,
    String message,
    String action,
  ) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        elevation: 0.0,
        behavior: SnackBarBehavior.floating,
        content: Text('Cancelled $message'),
        duration: const Duration(milliseconds: 3000),
      ),
    );
  }
}
