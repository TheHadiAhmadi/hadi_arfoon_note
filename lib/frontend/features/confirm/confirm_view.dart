import 'package:flutter/material.dart';

class ConfirmView extends StatelessWidget {
  final String title;
  final String message;
  final String confirmText;
  final String cancelText;

  const ConfirmView({
    super.key,
    required this.title,
    required this.message,
    required this.confirmText,
    required this.cancelText,
  });

  static Future<bool?> show(
    BuildContext context, {
    String title = 'Confirm Delete',
    String message = 'Are you sure you want to delete this?',
    String confirmText = 'Delete',
    String cancelText = 'Cancel',
  }) {
    return showDialog(
      context: context,
      builder: (_) => ConfirmView(
        title: title,
        message: message,
        confirmText: confirmText,
        cancelText: cancelText,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        title,
      ),
      content: Text(
        message,
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: Text(
            cancelText,
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(true);
          },
          child: Text(
            confirmText,
          ),
        ),
      ],
    );
  }
}
