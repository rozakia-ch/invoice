import 'package:hive/hive.dart';
import 'dart:async';

import 'package:invoice/models/note/note_model.dart';

class NoteHive {
  final String _boxName = "Note";
  // open a box
  Future<Box> noteBox() async {
    var box = await Hive.openBox<NoteModel>(_boxName);
    return box;
  }

  // get full notes
  Future<List<NoteModel>> getFullNotes() async {
    final box = await noteBox();
    List<NoteModel> notes = box.values.cast<NoteModel>().toList();
    return notes;
  }

  // to add data in box
  Future<void> addToBox(NoteModel note) async {
    final box = await noteBox();
    await box.add(note);
  }

  // update data
  Future<void> updateNote(int index, NoteModel note) async {
    final box = await noteBox();
    await box.putAt(index, note);
  }
}
