import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SettingsView extends StatefulWidget {
  final String initialLanguage;
  final String initialTheme;
  final void Function(String language, String theme) onSave;

  const SettingsView({
    super.key,
    required this.initialLanguage,
    required this.initialTheme,
    required this.onSave,
  });

  static void show(
    BuildContext context, {
    required String initialLanguage,
    required String initialTheme,
    required void Function(String language, String theme) onSave,
  }) {
    showDialog(
      context: context,
      builder: (_) => SettingsView(
        initialLanguage: initialLanguage,
        initialTheme: initialTheme,
        onSave: onSave,
      ),
    );
  }

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  late String selectedLanguage;
  late String selectedTheme;

  final List<String> languages = ['English', 'Spanish', 'French', 'German'];
  final List<String> themes = ['Light', 'Dark', 'System'];

  @override
  void initState() {
    super.initState();
    selectedLanguage = widget.initialLanguage;
    selectedTheme = widget.initialTheme;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 16,
          ),
          SvgPicture.asset('/images/settings.svg', width: 64, height: 64),
          Text('Arfoon Note Settigs',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          SizedBox(
            height: 16,
          ),
          _buildDropdown('Language', languages, selectedLanguage, (val) {
            if (val != null) setState(() => selectedLanguage = val);
          }),
          const SizedBox(height: 16),
          _buildDropdown('Theme', themes, selectedTheme, (val) {
            if (val != null) setState(() => selectedTheme = val);
          }),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            widget.onSave(selectedLanguage, selectedTheme);
            Navigator.of(context).pop();
          },
          child: const Text('Save'),
        ),
      ],
    );
  }

  Widget _buildDropdown(
    String label,
    List<String> items,
    String currentValue,
    ValueChanged<String?> onChanged,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade400),
            borderRadius: BorderRadius.circular(8),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: currentValue,
              isExpanded: true,
              onChanged: onChanged,
              items: items
                  .map((item) => DropdownMenuItem(
                        value: item,
                        child: Text(item),
                      ))
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }
}
