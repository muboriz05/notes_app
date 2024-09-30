import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:notes_app/const.dart';

class EmptyNotes extends StatelessWidget {
  const EmptyNotes({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text("Welcome to Quickly Notes",
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 24)),
            SvgPicture.asset(
              'assets/images/take-notes.svg',
              height: size.height * 0.4,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: size.width * 0.8,
                child: const Text(
                  "the essential features you need to jot down notes with ease",
                  style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
                  textAlign: TextAlign.center,
                ),
              ),
            )
          ],
        ),
        Positioned(
          bottom: size.height * 0.05,
          right: size.width * 0.15,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: size.width * 0.5,
                child: const Text(
                  "Click here to add your first note",
                  textAlign: TextAlign.end,
                  style: TextStyle(color: Colors.black26),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(
                  'assets/images/arrow.png',
                  color: Colors.black12,
                  height: 50,
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
