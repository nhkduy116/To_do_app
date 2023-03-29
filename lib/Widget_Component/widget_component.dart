// ignore_for_file: deprecated_member_use, unused_import

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:to_do_list/constant/color_constant.dart';
import 'package:to_do_list/model/note.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'dart:math';

import 'package:to_do_list/page/edit_note_page.dart';

class NoteBox extends StatefulWidget {
  final int id;
  final String title;
  final String content;
  final DateTime createDate;
  final bool isChecked;
  const NoteBox(
      {Key? key,
      required this.id,
      required this.title,
      required this.content,
      required this.createDate,
      required this.isChecked})
      : super(key: key);

  @override
  State<NoteBox> createState() => _NoteBoxState();
}

class _NoteBoxState extends State<NoteBox> {
  final rnd = new Random();
  int next(int min, int max) => min + rnd.nextInt(max - min);
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Container(
      height: height * 0.15,
      margin: EdgeInsets.only(top: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Color(rnd.nextInt(0xffffffff)),
      ),
      child: GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => EditNotePage(
                          id: widget.id,
                          title: widget.title,
                          content: widget.content,
                          createDate: widget.createDate,
                          isChecked: widget.isChecked,
                        )));
          },
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  DateFormat.yMMMMd('en_US').format(widget.createDate),
                  style: TextStyle(color: ColorConstant.colorTitle),
                ),
                Text(
                  widget.title,
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ],
            ),
          )),
    );
  }
}
