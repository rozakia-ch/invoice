part of 'note_cubit.dart';

abstract class NoteState extends Equatable {
  const NoteState();
}

class NoteInitial extends NoteState {
  @override
  List<Object> get props => [];
}

// loading
class NoteLoading extends NoteState {
  @override
  List<Object?> get props => [];
}

//  your notes
class ListNoteState extends NoteState {
  final List<NoteModel> notes; // get all notes
  const ListNoteState({required this.notes});
  @override
  List<Object?> get props => [];
}
