import 'package:arfoon_note/client/models/models.dart';
import 'package:arfoon_note/server/server.dart';
import 'package:isar/isar.dart';

class NoteServer {
  final Labels labels;
  final Notes notes;
  final Isar isar;
  const NoteServer(this.isar, {required this.labels, required this.notes});
  static NoteServer instance(Isar isar) {
    return NoteServer(
      isar,
      labels: Labels(isar: isar),
      notes: Notes(isar: isar),
    );
  }

  Future<void> seedDemoData() async {
    await isar.writeTxn(() async {
      await isar.clear();

      final work = Label(name: 'Work');
      final urgent = Label(name: 'Urgent');
      final ideas = Label(name: 'Ideas');

      final ids = await isar.labels.putAll([work, urgent, ideas]);

      var noteList = [
        Note(
            title: 'Groceries',
            details: 'Buy eggs and milk',
            labelIds: [ids[0]]),
        Note(
            title: 'Plan trip',
            details: 'Look up flights to Istanbul',
            labelIds: [ids[2]]),
        Note(
            title: 'Call doctor',
            details: 'Follow up on test results',
            labelIds: [ids[1]]),
      ];
      for (var note in noteList) {
        await notes.insert(note);
      }
    });
  }
}
