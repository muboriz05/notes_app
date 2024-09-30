import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:notes_app/const.dart';
import 'package:notes_app/db/notes_database.dart';
import 'package:notes_app/models/note.dart';
import 'package:notes_app/screens/edit_add_note_screen/components/color_radio_button.dart';

import 'package:notes_app/screens/edit_add_note_screen/components/confirm_delete_dialog.dart';
import 'package:notes_app/screens/homepage/home_page.dart';

class EditAddNoteScreen extends StatefulWidget {
  final Note? note;
  const EditAddNoteScreen({Key? key, this.note}) : super(key: key);

  @override
  _EditAddNoteScreenState createState() => _EditAddNoteScreenState();
}

class _EditAddNoteScreenState extends State<EditAddNoteScreen> {
  final TextEditingController _title = TextEditingController();
  final TextEditingController _content = TextEditingController();
  int radioButtonValue = 0;

  @override
  void initState() {
    super.initState();

    _title.text = widget.note?.title ?? "";
    _content.text = widget.note?.content ?? "";
    radioButtonValue = widget.note?.color ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (widget.note != null)
                  Text("Last modified: " +
                      DateFormat('dd-MM-yyyy - kk:mm')
                          .format(widget.note!.createdAt)),
                ColorRadioButton(
                  radioButtonSize: size.width > 600 ? 50 : 30,
                  padding: 0,
                  colorItems: kColorList,
                  currentIndex: radioButtonValue,
                  onTap: (_index) {
                    setState(() {
                      radioButtonValue = _index;
                    });
                  },
                ),
                TextField(
                    cursorColor: kDarkColor1,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 30),
                    decoration: const InputDecoration(
                      hintText: "Title",
                      border: InputBorder.none,
                    ),
                    minLines: 1,
                    maxLines: 3,
                    keyboardType: TextInputType.multiline,
                    controller: _title),
                Expanded(
                  child: TextField(
                      cursorColor: kDarkColor1,
                      style: const TextStyle(
                          fontWeight: FontWeight.normal, fontSize: 20),
                      decoration: const InputDecoration(
                        hintText: "Write something...",
                        border: InputBorder.none,
                      ),
                      minLines: 20,
                      maxLines: 999,
                      keyboardType: TextInputType.multiline,
                      controller: _content),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(
          Icons.save,
          color: kDarkColor1,
        ),
        elevation: 0,
        backgroundColor: kYellow,
        onPressed: () {
          if (_content.text.isEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text(
              "insert content",
            )));
          } else {
            addNote();
            Navigator.pop(context);
          }
        },
      ),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                if (widget.note != null)
                  IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () async {
                      showDialog(
                          context: context,
                          builder: (_) => ConfirmDeleteDialog(
                                onPressedYes: () async {
                                  Navigator.pop(context);
                                  await NotesDatabase.instance
                                      .deleteNote(widget.note?.id);

                                  Navigator.pop(context);
                                },
                              ));
                    },
                  ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Future addNote() async {
    if (widget.note == null) {
      final note = Note(
        title: _title.text,
        content: _content.text,
        color: radioButtonValue,
        createdAt: DateTime.now(),
      );

      await NotesDatabase.instance.insertNote(note);
    } else {
      final Note note = widget.note!.copy(
        title: _title.text,
        content: _content.text,
        color: radioButtonValue,
        createdAt: DateTime.now(),
      );

      await NotesDatabase.instance.updateNote(note);
    }
  }
}
