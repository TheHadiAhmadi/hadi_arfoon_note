import 'package:arfoon_note/client/models/models.dart';
import 'package:arfoon_note/frontend/features/label/label_edit_view.dart';
import 'package:arfoon_note/frontend/features/sidebar/sidebar_view.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final TextEditingController _searchController = TextEditingController();
  int id = 5;

  final List<Label> labels = [
    Label(name: 'Work', id: 1),
    Label(name: 'Personal', id: 2),
    Label(name: 'Urgent', id: 3),
    Label(name: 'Ideas', id: 4)
  ];

  final List<String> notes = [
    'Note 1: Buy groceries',
    'Note 2: Meeting at 10 AM',
    'Note 3: Flutter task',
    'Note 4: Call mom',
  ];

  String searchQuery = '';

  addLabel(label) {
    setState(() {
      labels.add(Label(name: label, id: id++));
    });
  }

  deleteLabel(id) {
    setState(() {
      final index = labels.indexWhere((l) => l.id == id);

      labels.removeAt(index);
    });
  }

  updateLabel(dynamic id, String label) {
    setState(() {
      final index = labels.indexWhere((l) => l.id == id);
      if (index != -1) {
        labels[index] = Label(name: label, id: id);
      }
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<String> get filteredNotes {
    return notes.where((note) {
      final matchesSearch =
          note.toLowerCase().contains(searchQuery.toLowerCase());
      // final matchesLabel =
      //     selectedLabel == null || note.contains(selectedLabel?.name);
      return matchesSearch;
    }).toList();
  }

  List<Label> getLabels() {
    return labels;
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width >= 800;

    final sidebar = SidebarView(
        getLabels: getLabels,
        addLabel: addLabel,
        deleteLabel: deleteLabel,
        updateLabel: updateLabel);

    final mainContent = Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          TextField(
            controller: _searchController,
            decoration: const InputDecoration(
              labelText: 'Search notes',
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(),
            ),
            onChanged: (val) {
              setState(() => searchQuery = val);
            },
          ),
          const SizedBox(height: 16),
          // SizedBox(
          //   height: 40,
          //   child: ListView.separated(
          //     scrollDirection: Axis.horizontal,
          //     itemCount: labels.length + 1,
          //     separatorBuilder: (_, __) => const SizedBox(width: 8),
          //     itemBuilder: (context, index) {
          //       if (index == 0) {
          //         return ChoiceChip(
          //           label: const Text('All'),
          //           selected: selectedLabel == null,
          //           onSelected: (_) => setState(() => selectedLabel = null),
          //         );
          //       }
          //       final label = labels[index - 1];
          //       return ChoiceChip(
          //         label: Text(label.name),
          //         selected: selectedLabel?.id == label.id,
          //         onSelected: (selected) {
          //           setState(() => selectedLabel = selected ? label : null);
          //         },
          //       );
          //     },
          //   ),
          // ),
          const SizedBox(height: 16),
          Expanded(
            child: filteredNotes.isEmpty
                ? const Center(child: Text('No notes found'))
                : ListView.builder(
                    itemCount: filteredNotes.length,
                    itemBuilder: (context, index) {
                      final note = filteredNotes[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 6),
                        child: ListTile(
                          title: Text(note),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      drawer: isDesktop ? null : Drawer(child: sidebar),
      body: isDesktop
          ? Row(
              children: [
                SizedBox(
                  width: 250,
                  child: Material(
                    elevation: 2,
                    child: sidebar,
                  ),
                ),
                Expanded(child: mainContent),
              ],
            )
          : mainContent,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          LabelEditView.show(context,
              initialValue: '',
              onSave: (value) => print(value),
              onDelete: () => print("Deleted"));
        },
        child: const Icon(Icons.add),
        tooltip: 'Edit Labels',
      ),
    );
  }
}
