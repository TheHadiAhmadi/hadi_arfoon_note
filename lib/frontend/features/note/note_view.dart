import 'package:flutter/material.dart';

class NoteView extends StatelessWidget {
  const NoteView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Note View'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: const Column(children: [
        Text("Has back button"),
        Text("Updated at 17 Dec"),
        Text("Untitled"),
        Text("Description"),
        Text('Labels and colors')
      ]),
    );
  }
}
