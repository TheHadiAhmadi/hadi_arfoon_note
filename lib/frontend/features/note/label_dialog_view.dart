import 'package:flutter/material.dart';

class AddEditLabelView extends StatefulWidget {
  const AddEditLabelView({super.key});

  @override
  State<StatefulWidget> createState() {
    return _AddEditLabelViewState();
  }
}

class _AddEditLabelViewState extends State<AddEditLabelView> {
  _AddEditLabelViewState();

  onClose() {}

  onSave() {}

  show(BuildContext context) {
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            content: const Text("Hello"),
            actions: [
              TextButton(
                onPressed: onClose,
                child: const Text("Cancel"),
              ),
              TextButton(onPressed: onSave, child: const Text('Save'))
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextButton(
        onPressed: () {
          show(context);
        },
        child: const Text("Open"),
      ),
    );
  }
}
