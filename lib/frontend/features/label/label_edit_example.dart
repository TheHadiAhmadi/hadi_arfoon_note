import 'package:arfoon_note/frontend/frontend.dart';
import 'package:flutter/material.dart';
import 'label_edit_view.dart';

class LabelEditExample extends StatefulWidget {
  const LabelEditExample({super.key});

  @override
  State<LabelEditExample> createState() => _LabelEditExampleState();
}

class _LabelEditExampleState extends State<LabelEditExample> {
  List<String> labels = ['Work', 'Personal', 'Ideas'];

  void _editLabel(int index) {
    LabelEditView.show(
      context,
      initialValue: labels[index],
      onSave: (value) {
        setState(() => labels[index] = value);
      },
      onDelete: () {
        setState(() => labels.removeAt(index));
      },
    );
  }

  void _addLabel() {
    LabelEditView.show(
      context,
      initialValue: '',
      onSave: (value) {
        if (value.isNotEmpty) {
          setState(() => labels.add(value));
        }
      },
      onDelete: () {},
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Label Manager'),
      ),
      backgroundColor: Colors.black,
      body: ListView.builder(
        itemCount: labels.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(labels[index],
                style: const TextStyle(color: Colors.white)),
            trailing: IconButton(
              icon: const Icon(Icons.edit, color: Colors.white54),
              onPressed: () => _editLabel(index),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addLabel,
        backgroundColor: Colors.greenAccent,
        child: const Icon(Icons.add, color: Colors.black),
      ),
    );
  }
}
