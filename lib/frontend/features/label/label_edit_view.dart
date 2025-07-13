import 'package:flutter/material.dart';

class LabelEditView extends StatefulWidget {
  final String initialValue;
  final void Function(String value) onSave;
  final VoidCallback onDelete;

  const LabelEditView({
    required this.initialValue,
    required this.onSave,
    required this.onDelete,
    super.key,
  });

  static Future<void> show(
    BuildContext context, {
    required String initialValue,
    required void Function(String value) onSave,
    required VoidCallback onDelete,
  }) {
    return showDialog(
      context: context,
      builder: (_) => LabelEditView(
        initialValue: initialValue,
        onSave: onSave,
        onDelete: onDelete,
      ),
    );
  }

  @override
  State<LabelEditView> createState() => _LabelEditViewState();
}

class _LabelEditViewState extends State<LabelEditView> {
  late TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController(text: widget.initialValue);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.grey[900],
      title: const Text('Edit Label', style: TextStyle(color: Colors.white)),
      content: TextField(
        controller: controller,
        style: const TextStyle(color: Colors.white),
        decoration: const InputDecoration(
          hintText: 'Enter label name',
          hintStyle: TextStyle(color: Colors.white54),
          enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white24)),
          focusedBorder:
              UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
            widget.onDelete();
          },
          child:
              const Text('Delete', style: TextStyle(color: Colors.redAccent)),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel', style: TextStyle(color: Colors.grey)),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
            widget.onSave(controller.text.trim());
          },
          child:
              const Text('Save', style: TextStyle(color: Colors.greenAccent)),
        ),
      ],
    );
  }
}
