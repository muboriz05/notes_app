import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/const.dart';
import 'package:notes_app/db/notes_database.dart';
import 'package:notes_app/models/note.dart';
import 'package:notes_app/screens/edit_add_note_screen/components/confirm_delete_dialog.dart';

class SingleNote extends StatelessWidget {
  final int? id;
  final String title, content;
  final int color;
  final DateTime createdAt;
  final GestureTapCallback? onTap;
  const SingleNote(
      {Key? key,
      this.title = "Title",
      this.content = "content",
      this.color = 0,
      this.onTap,
      required this.id,
      required this.createdAt})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Container(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 5.0),
                  child: Text(
                    title,
                    style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                        color: kDarkColor1),
                  ),
                ),
                const SizedBox(height: 6),
                Text(content)
              ],
            ),
          ),
          color: Color.alphaBlend(const Color(0xAAFFFFFF), kColorList[color]),
        ),
      ),
    );
  }
}
