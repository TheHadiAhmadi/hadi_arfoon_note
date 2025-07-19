import 'package:arfoon_note/client/models/label.dart';
import 'package:isar/isar.dart';

part 'note.g.dart';

@Collection()
class Note {
  Id? id;
  String? title;
  String? details;
  int? colorId;
  List<Id> labelIds;

  Note({
    this.id,
    this.title,
    this.details,
    this.colorId,
    required this.labelIds,
  });

  @Ignore()
  List<Label> labels = [];

  Note copyWith({
    Id? id,
    String? title,
    String? details,
    int? colorId,
    List<Id>? labelIds,
    List<Label>? labels,
  }) {
    return Note(
      id: id ?? this.id,
      title: title ?? this.title,
      details: details ?? this.details,
      colorId: colorId ?? this.colorId,
      labelIds: labelIds ?? this.labelIds,
    )..labels = labels ?? this.labels;
  }

  @Ignore()
  Future<void> loadLabels(Isar isar) async {
    if (labelIds.isEmpty) {
      labels = [];
      return;
    }

    final query = isar.labels.filter().group((q) {
      var orQuery = q.idEqualTo(labelIds.first);
      for (var id in labelIds.skip(1)) {
        orQuery = orQuery.or().idEqualTo(id);
      }
      return orQuery;
    });

    labels = await query.findAll();
  }
}
