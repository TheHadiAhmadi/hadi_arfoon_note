import 'package:arfoon_note/frontend/features/settings/settings_view.dart';
import 'package:flutter/material.dart';

class SettingsExample extends StatefulWidget {
  const SettingsExample({super.key});

  @override
  State<SettingsExample> createState() => _SettingsExampleState();
}

class _SettingsExampleState extends State<SettingsExample> {
  String currentLanguage = 'English';
  String currentTheme = 'Light';

  void onSave(String language, String theme) {
    setState(() {
      currentLanguage = language;
      currentTheme = theme;
    });
    print('Saved settings: Language=$language, Theme=$theme');
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: IconButton(
      icon: const Icon(Icons.settings),
      onPressed: () {
        SettingsView.show(
          context,
          initialLanguage: currentLanguage,
          initialTheme: currentTheme,
          onSave: onSave,
        );
      },
    ));
  }
}
