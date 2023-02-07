import 'package:flutter/material.dart';
import 'package:note_app/domain/model/note.dart';
import 'package:note_app/presentation/add_edit_note/add_edit_note_screen.dart';
import 'package:note_app/presentation/notes/components/note_item.dart';
import 'package:note_app/ui/colors.dart';

class NoteScreen extends StatelessWidget {
  const NoteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Your note',
          style: TextStyle(fontSize: 30.0),
        ),
        centerTitle: false,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.sort),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const AddEditNoteScreen()));
        },
        child: const Icon(Icons.add),
      ),
      body: ListView(
        children: [
          NoteItem(
            note: Note(
              title: 'title1',
              content: 'content',
              color: wisteria.value,
              timestamp: 1,
            ),
          ),
          NoteItem(
            note: Note(
              title: 'title2',
              content: 'content',
              color: skyBlue.value,
              timestamp: 1,
            ),
          ),
        ],
      ),
    );
  }
}
