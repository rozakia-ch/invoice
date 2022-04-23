import 'package:hive/hive.dart';

part 'note_model.g.dart';

@HiveType(typeId: 2)
class NoteModel {
  @HiveField(0)
  final String note;

  NoteModel({required this.note});
}
