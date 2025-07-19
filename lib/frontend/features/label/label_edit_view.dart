import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
      contentPadding: const EdgeInsets.all(16),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          const Text(
            'Edit Label',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: controller,
            autofocus: true,
            decoration: InputDecoration(
              hintText: 'Enter label name',
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
      actions: [
        if (widget.initialValue.isNotEmpty)
          TextButton(
            onPressed: () {
              widget.onDelete();
            },
            child:
                const Text('Delete', style: TextStyle(color: Colors.redAccent)),
          ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel', style: TextStyle(color: Colors.grey)),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
            widget.onSave(controller.text.trim());
          },
          child: const Text('Save'),
        ),
      ],
    );
  }
}
