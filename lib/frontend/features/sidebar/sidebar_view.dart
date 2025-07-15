import 'package:arfoon_note/client/models/models.dart';
import 'package:arfoon_note/frontend/frontend.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SidebarView extends StatefulWidget {
  const SidebarView(
      {super.key,
      required this.getLabels,
      required this.addLabel,
      required this.deleteLabel,
      required this.updateLabel});

  final List<Label> Function() getLabels;
  final Function(dynamic) deleteLabel;
  final Function(dynamic, String) updateLabel;
  final Function(String) addLabel;

  @override
  State<SidebarView> createState() => _SidebarViewState();
}

class _SidebarViewState extends State<SidebarView> {
  List<Label> labels = [];
  Label? currentLabel;

  @override
  void initState() {
    super.initState();
    labels = widget.getLabels();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildLogo(),
          Padding(
              padding: EdgeInsetsGeometry.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.notes, color: Colors.black),
                      const SizedBox(width: 8),
                      const Text(
                        'All Notes',
                        style: TextStyle(color: Colors.black, fontSize: 16),
                      ),
                    ],
                  ),
                  const Icon(Icons.chevron_right, color: Colors.grey),
                ],
              )),
          const SizedBox(height: 40),
          Padding(
              padding: EdgeInsetsGeometry.only(left: 8),
              child: Text('Labels',
                  style: TextStyle(color: Colors.grey.shade500))),
          const SizedBox(height: 16),
          Expanded(
              child: Padding(
                  padding: EdgeInsetsGeometry.all(16),
                  child: ListView.separated(
                      separatorBuilder: (_, __) => const SizedBox(height: 8),
                      itemCount: labels.length,
                      itemBuilder: (context, index) {
                        return _buildLabel(context, labels[index]);
                      }))),

          Spacer(),
          InkWell(
              onTap: () {
                onLabelAdd(context);
              },
              borderRadius: BorderRadius.circular(8),
              child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                  child: Row(children: [
                    SvgPicture.asset('/images/add_label.svg',
                        width: 24, height: 24),
                    SizedBox(width: 8),
                    Text('Add Label')
                  ]))),
          InkWell(
              onTap: () {
                onSettingsOpen(context);
              },
              borderRadius: BorderRadius.circular(8),
              child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                  child: Row(
                    children: [
                      SvgPicture.asset('/images/settings_outlined.svg',
                          width: 24, height: 24),
                      SizedBox(width: 8),
                      Text('Settings')
                    ],
                  ))),
          // _buildSection('🚪 Logout'),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  onLabelAddSave(label) {
    widget.addLabel(label);
  }

  onLabelAdd(context) {
    LabelEditView.show(context,
        initialValue: '', onSave: onLabelAddSave, onDelete: () {});
  }

  onSettingsSave(language, theme) {
    print('Save Settings $language $theme');
  }

  onSettingsOpen(context) {
    SettingsView.show(context,
        initialLanguage: 'English',
        initialTheme: 'System Theme',
        onSave: onSettingsSave);
  }

  Widget _buildLogo() {
    return Padding(
        padding: EdgeInsets.all(16),
        child: Row(
          children: [
            SvgPicture.asset('/images/logo.svg', width: 40, height: 40),
            SizedBox(width: 8),
            Column(children: [
              Text('Arfoon Note',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              Text('Arfoon Note',
                  style: TextStyle(color: Colors.grey.shade700)),
            ]),
          ],
        ));
  }

  onLabelSave(newValue) {
    widget.updateLabel(currentLabel!.id, newValue);
  }

  onLabelDelete() {
    widget.deleteLabel(currentLabel!.id);
  }

  onLabelEdit(context, label) {
    setState(() {
      currentLabel = label;
    });

    if (currentLabel != null) {
      LabelEditView.show(context,
          initialValue: currentLabel!.name,
          onSave: onLabelSave,
          onDelete: onLabelDelete);
    }
  }

  Widget _buildLabel(BuildContext context, Label label) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Row(
        children: [
          const Icon(Icons.paste, color: Colors.grey),
          const SizedBox(width: 16),
          Text(
            label.name,
            style: const TextStyle(fontSize: 16, color: Colors.grey),
          ),
          const Spacer(),
          IconButton(
            onPressed: () => onLabelEdit(context, label),
            icon: const Icon(Icons.edit, color: Colors.grey),
            splashRadius: 20,
          )
        ],
      ),
    );
  }
}
