import 'package:arfoon_note/frontend/frontend.dart';
import 'package:flutter/material.dart';

class ConfirmExample extends StatelessWidget {
  const ConfirmExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: TextButton(
      onPressed: () async {
        bool? result = await ConfirmView.show(context);
        if (result!) {
          print("Confirm");
        }
      },
      child: const Text('Open'),
    ));
  }
}
