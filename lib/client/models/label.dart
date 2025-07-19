import 'package:isar/isar.dart';

part 'label.g.dart';

@Collection()
class Label {
  Id? id;
  String name;
  String? details;
  Label({
    this.id,
    required this.name,
    this.details,
  });

  Label copyWith({
    Id? id,
    String? name,
    String? details,
  }) {
    return Label(
      id: id ?? this.id,
      name: name ?? this.name,
      details: details ?? this.details,
    );
  }
}
