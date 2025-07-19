import 'package:arfoon_note/client/client.dart';
import 'package:arfoon_note/frontend/data/data.dart';
import 'package:arfoon_note/client/models/models.dart';
import 'package:arfoon_note/frontend/features/features.dart';
import 'package:arfoon_note/frontend/features/label/label_edit_view.dart';
import 'package:arfoon_note/frontend/features/sidebar/sidebar_view.dart';
import 'package:arfoon_note/integration/integration.dart';
import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:arfoon_note/client/client.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final TextEditingController _searchController = TextEditingController();

List<Label> labels = [];
List<Note> notes = [];

@override
void initState() {
  super.initState();
  loadLabels();
  loadNotes();
}

String userName = 'Hadi Ahmadi';
String searchQuery = '';

void loadLabels() async {
  setState(() {
    labels = List.from(FakeData.labels);
  });
}

void loadNotes() async {
  setState(() {
    notes = List.from(FakeData.notes);
  });
}

void addLabel(String label) {
  setState(() {
    labels.add(Label(id: labels.length + 1, name: label));
  });
}

void deleteLabel(Id id) {
  setState(() {
    print("delete id=$id");
    labels.removeWhere((l) => l.id == id);
  });
}

void updateLabel(Id id, String name) {
  setState(() {
    print("update id=$id name=$name");
    final index = labels.indexWhere((l) => l.id == id);
    if (index != -1) {
      labels[index] = labels[index].copyWith(name: name);
    }
  });
}

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<Note> get filteredNotes {
    return notes;
  }

  List<Label> getLabels() {
    return labels;
  }

  setUserName(String name) {
    setState(() {
      userName = name;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width >= 800;

    final sidebar = SidebarView(
        getLabels: getLabels,
        addLabel: addLabel,
        deleteLabel: deleteLabel,
        updateLabel: updateLabel,
        setUserName: setUserName,
        userName: userName);

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
                      return NoteCardView(note: note, labels: labels);
                      
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
          print('Add Note');
          // LabelEditView.show(context,
          //     initialValue: '',
          //     onSave: (value) => print(value),
          //     onDelete: () => print("Deleted"));
        },
        child: const Icon(Icons.add),
        tooltip: 'Add note',
      ),
    );
  }
}
