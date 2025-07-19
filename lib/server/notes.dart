import 'package:isar/isar.dart';

import 'package:arfoon_note/client/client.dart';

class Notes {
  final Isar isar;
  const Notes({required this.isar});

  Future<Note> insert(Note note) async {
    var res = await isar.writeTxn(() async {
      return await isar.notes.put(note);
    });
    return note.copyWith(id: res);
  }

  Future<List<Note>> list({Pagination? pagination}) async {
    if (pagination != null) {
      var notes = await isar.notes
          .where()
          .offset(pagination.offset)
          .limit(pagination.limit)
          .findAll();

      for (var note in notes) {
        await note.loadLabels(isar);
      }
      return notes;
    }

    return await isar.notes.where().findAll();
  }

  Future<Note?> get(int id) async {
    var note = await isar.notes.get(id);
    await note?.loadLabels(isar);
    return note;
  }

  Future<Note?> updateNote(Note note) async {
    var res = await isar.writeTxn(() async {
      return await isar.notes.put(note);
    });
    return note.copyWith(id: res);
  }

  Future deleteNote(int id) async {
    await isar.writeTxn(() async {
      return await isar.notes.delete(id);
    });
  }
}
