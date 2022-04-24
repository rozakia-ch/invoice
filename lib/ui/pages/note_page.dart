import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:invoice/cubits/note/note_cubit.dart';
import 'package:invoice/hive/note_hive.dart';
import 'package:invoice/ui/widgets/app_drawer.dart';
import 'package:invoice/ui/widgets/app_will_pop_scope.dart';

class NotePage extends StatefulWidget {
  const NotePage({Key? key}) : super(key: key);

  @override
  State<NotePage> createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  final NoteHive _noteHive = NoteHive();
  final _formKey = GlobalKey<FormState>();
  final _noteController = TextEditingController();
  String _note = '';

  _getNote() async {
    await _noteHive.getFullNotes().then((value) => _note = value.first.note);
    return _note;
  }

  @override
  Widget build(BuildContext context) {
    return AppWillPopScope(
      child: Scaffold(
        endDrawer: const AppDrawer(),
        appBar: AppBar(
          elevation: 0,
          title: const Text("Note"),
        ),
        body: FutureBuilder(
          future: _getNote(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              _noteController.text = snapshot.data.toString();
              return SingleChildScrollView(
                padding: const EdgeInsets.all(10.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        // autofocus: true,
                        controller: _noteController,
                        keyboardType: TextInputType.multiline,
                        textAlignVertical: TextAlignVertical.top,
                        maxLines: 50,
                        onChanged: (value) {
                          BlocProvider.of<NoteCubit>(context).mapNoteEdit(
                            index: 0,
                            newNote: value,
                          );
                        },
                        decoration: const InputDecoration(
                          alignLabelWithHint: true,
                          contentPadding: EdgeInsets.all(10.0),
                          border: InputBorder.none,
                          hintText: 'Ketik disini',
                        ),
                      ),
                    ],
                  ),
                ),
              );
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}
