import 'package:arfoon_note/frontend/features/confirm/confirm_example.dart';
import 'package:arfoon_note/frontend/features/examples/examples_view.dart';
import 'package:arfoon_note/frontend/features/home/home_example.dart';
import 'package:arfoon_note/frontend/features/label/label_edit_example.dart';
import 'package:arfoon_note/frontend/features/examples/example_item.dart';
import 'package:arfoon_note/frontend/features/settings/settings_example.dart';
import 'package:flutter/material.dart';

class ExamplePage extends StatefulWidget {
  const ExamplePage({super.key});

  @override
  State<ExamplePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<ExamplePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        title: const Text('Examples'),
      ),
      body: const ExamplesView(),
    );
  }
}
