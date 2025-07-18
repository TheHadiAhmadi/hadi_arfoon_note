import 'package:arfoon_note/client/client.dart';
import 'package:arfoon_note/frontend/frontend.dart';
import 'package:arfoon_note/integration/integration.dart';
import 'package:arfoon_note/integration/main_app.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

Future<void> main() async {

  if (kReleaseMode) {
    runApp(const FrontendApp(home: MainApp()));
    return;
  }
  runApp(const FrontendApp(home: ExamplePage()));
}
