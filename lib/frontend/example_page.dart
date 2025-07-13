import 'package:arfoon_note/frontend/features/confirm/confirm_example.dart';
import 'package:arfoon_note/frontend/features/home/home_example.dart';
import 'package:arfoon_note/frontend/features/label/label_edit_example.dart';
import 'package:arfoon_note/frontend/features/note/label_dialog_view.dart';
import 'package:arfoon_note/frontend/features/home/example_item.dart';
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
      body: Column(
        children: [
          ExampleItem(
              title: 'HomeExample',
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const HomeExample()));
              },
              description:
                  'Push to HomeExample and Example returns HomeView with calls of getNote(file), getLabels, addNote, onSettingTap, onProfileTap.'),
          ExampleItem(
              title: 'ProfileView',
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const HomeExample()));
                // Navigator.push(context, MaterialPageRoute(builder: (_) => const ProfileView()));
              },
              description:
                  'This is a dialog and show as ProfileView().show(context) and has parameters of: title, submitText, onSubmit(s)'),
          ExampleItem(
              title: 'SettingsView',
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const SettingsExample()));
                // Navigator.push(context, MaterialPageRoute(builder: (_) => const ProfileView()));
              },
              description:
                  'This is a dialog and show as SettingsView().show(context) and has parameters of currentLanguage, onLanguageChanged(llang), currentTheme, onThemeChanged(t)'),
          ExampleItem(
              title: 'AddEditLabelView',
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => const LabelEditExample()));
                // Navigator.push(context, MaterialPageRoute(builder: (_) => const ProfileView()));
              },
              description:
                  'This is a dialog and show as AddEditLabelView().show(context) and has parameters of: title, onSubmit(s), onDelete'),
          ExampleItem(
              title: 'SureView',
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const ConfirmExample()));
                // Navigator.push(context, MaterialPageRoute(builder: (_) => const ProfileView()));
              },
              description:
                  'This is a dialog and show as SureView().show(context) and has parameters of: title, subtitle, sureText, onSure()'),
        ],
      ),
    );
  }
}
