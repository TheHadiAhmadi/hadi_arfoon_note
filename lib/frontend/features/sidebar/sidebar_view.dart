import 'package:arfoon_note/client/models/models.dart';
import 'package:arfoon_note/frontend/features/profile/profile_view.dart';
import 'package:arfoon_note/frontend/frontend.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:isar/isar.dart';

class SidebarView extends StatefulWidget {
  const SidebarView(
      {super.key,
      required this.getLabels,
      required this.addLabel,
      required this.deleteLabel,
      required this.updateLabel,
      required this.setUserName,
      required this.userName});

  final List<Label> Function() getLabels;
  final void Function(int) deleteLabel;
  final void Function(int, String) updateLabel;
  final void Function(String) addLabel;
  final void Function(String) setUserName;
  final String userName;

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
              child: Container(
                  color: Colors.white,
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
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
                  ))),
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
          Padding(
              padding: EdgeInsets.all(8),
              child: Column(
                children: [
                  InkWell(
                      onTap: () {
                        onLabelAdd(context);
                      },
                      borderRadius: BorderRadius.circular(8),
                      child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 12),
                          child: Row(children: [
                            SvgPicture.asset('/images/add_label.svg',
                                width: 24, height: 24),
                            SizedBox(width: 8),
                            Text('Add Label')
                          ]))),
                  const SizedBox(height: 8),
                  InkWell(
                      onTap: () {
                        onSettingsOpen(context);
                      },
                      borderRadius: BorderRadius.circular(8),
                      child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 12),
                          child: Row(
                            children: [
                              SvgPicture.asset('/images/settings_outlined.svg',
                                  width: 24, height: 24),
                              SizedBox(width: 8),
                              Text('Settings')
                            ],
                          ))),
                  const SizedBox(height: 8),
                  InkWell(
                      onTap: () {
                        onProfileOpen(context);
                      },
                      borderRadius: BorderRadius.circular(8),
                      child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 12),
                          child: Row(children: [
                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(8)),
                              child: Padding(
                                  padding: EdgeInsets.all(8),
                                  child: Text(
                                    'AP',
                                    style: TextStyle(color: Colors.white),
                                  )),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                                child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(widget.userName,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold)),
                                Text('Good Morning',
                                    style:
                                        TextStyle(color: Colors.grey.shade700))
                              ],
                            )),
                            SvgPicture.asset('images/cta.svg',
                                width: 16, height: 16)
                          ]))),
                  const SizedBox(height: 8),
                ],
              )),
        ],
      ),
    );
  }

  onProfileOpen(context) async {
    String? newName = await ProfileView.show(context, name: widget.userName);

    if (newName != null && newName.isNotEmpty) {
      widget.setUserName(newName);
    }
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
        initialTheme: 'System',
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
    widget.updateLabel(currentLabel!.id!, newValue);
  }

  onLabelDelete() async {
    bool? result = await ConfirmView.show(context);

    if (result!) {
      widget.deleteLabel(currentLabel!.id!);
      Navigator.of(context).pop();
    }
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
          Icon(Icons.paste, color: Colors.grey.shade700),
          const SizedBox(width: 16),
          Text(
            label.name,
            style: TextStyle(fontSize: 16, color: Colors.grey.shade700),
          ),
          const Spacer(),
          IconButton(
            onPressed: () => onLabelEdit(context, label),
            icon: Icon(Icons.edit, color: Colors.grey.shade700),
            splashRadius: 20,
          )
        ],
      ),
    );
  }
}
