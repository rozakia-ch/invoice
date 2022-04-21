import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:invoice/hive/note_hive.dart';
import 'package:invoice/models/note/note_model.dart';

part 'note_state.dart';

class NoteCubit extends Cubit<NoteState> {
  final NoteHive _noteHive = NoteHive();
  List<NoteModel> _notes = [];
  NoteCubit() : super(NoteInitial());

  // Stream Functions
  void mapInitial() async {
    emit(NoteLoading());
    await _getNotes();
    emit(ListNoteState(notes: _notes));
  }

  void mapNoteAdd({required String note}) async {
    emit(NoteLoading());
    await addNote(note: note);
    emit(ListNoteState(notes: _notes));
  }

  void mapNoteEdit({
    required int index,
    required String newNote,
  }) async {
    emit(NoteLoading());
    await updateNote(index: index, newNote: newNote);
    emit(ListNoteState(notes: _notes));
  }

  // Helper Functions
  Future<void> _getNotes() async {
    await _noteHive.getFullNotes().then((value) => _notes = value);
  }

  Future<void> addNote({required String note}) async {
    await _noteHive.addToBox(NoteModel(note: note));
    await _getNotes();
  }

  Future<void> updateNote({
    required int index,
    required String newNote,
  }) async {
    await _noteHive.updateNote(index, NoteModel(note: newNote));
    await _getNotes();
  }
}
