// ignore_for_file: unused_import, unused_local_variable, deprecated_member_use, unused_element, unused_field, must_call_super

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:to_do_list/database/notes_database.dart';
import 'package:to_do_list/model/note.dart';
import 'package:to_do_list/constant/color_constant.dart';
import 'package:to_do_list/page/note_page.dart';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';

class EditNotePage extends StatefulWidget {
  final int id;
  final String title;
  final String content;
  final DateTime createDate;
  final bool isChecked;
  const EditNotePage(
      {Key? key,
      required this.id,
      required this.title,
      required this.content,
      required this.createDate,
      required this.isChecked})
      : super(key: key);

  @override
  State<EditNotePage> createState() => _EditNotePageState();
}

class _EditNotePageState extends State<EditNotePage> {
  TextEditingController myController = TextEditingController();
  TextEditingController myControllerContent = TextEditingController();
  late var db = DatabaseConnect();

  void initState() {
    super.initState();
    if (widget.title != "") {
      myController.text = widget.title;
    }
    if (widget.content != "") {
      myControllerContent.text = widget.content;
    }
  }

  void _showAlertDialogDelete(BuildContext context) {
    showCupertinoModalPopup<void>(
      barrierColor: Colors.transparent,
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: const Text('Delete?'),
        content: const Text('Are you sure to delete this Note?'),
        actions: <CupertinoDialogAction>[
          CupertinoDialogAction(
            /// This parameter indicates this action is the default,
            /// and turns the action's text to bold text.
            isDefaultAction: true,
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('No'),
          ),
          CupertinoDialogAction(
            /// This parameter indicates the action would perform
            /// a destructive action such as deletion, and turns
            /// the action's text color to red.
            isDestructiveAction: true,
            onPressed: () async {
              await db.deleteNote(Note(
                  id: widget.id,
                  title: myController.text,
                  content: myControllerContent.text,
                  createDate: widget.createDate,
                  isChecked: widget.isChecked));
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => NotePage()));
            },
            child: const Text('Yes'),
          ),
        ],
      ),
    );
  }

  void _showAlertDialogSave(BuildContext context) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: const Text('Save?'),
        content: const Text('Are you sure to edit this Note?'),
        actions: <CupertinoDialogAction>[
          CupertinoDialogAction(
            /// This parameter indicates this action is the default,
            /// and turns the action's text to bold text.
            isDefaultAction: true,
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('No'),
          ),
          CupertinoDialogAction(
            /// This parameter indicates the action would perform
            /// a destructive action such as deletion, and turns
            /// the action's text color to red.
            isDestructiveAction: true,
            onPressed: () async {
              await db.upgradeNote(Note(
                  id: widget.id,
                  title: myController.text,
                  content: myControllerContent.text,
                  createDate: widget.createDate,
                  isChecked: widget.isChecked));
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => NotePage()));
            },
            child: const Text('Yes'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: ColorConstant.primaryColor,
          elevation: 0,
          leading: IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => NotePage()));
              },
              icon: Icon(Icons.arrow_back)),
          actions: <Widget>[
            Container(
                width: width * 0.25,
                padding: EdgeInsets.all(10),
                child: Theme(
                    data: ThemeData(
                        dialogBackgroundColor: ColorConstant.colorSave),
                    child: Builder(builder: (context) {
                      return FlatButton(
                        color: ColorConstant.colorBtnDel,
                        onPressed: () {
                          FocusManager.instance.primaryFocus?.unfocus();
                          // showDialog<String>(
                          //   barrierColor: Colors.transparent,
                          //   context: context,
                          //   builder: (BuildContext context) => AlertDialog(
                          //     title: const Text(
                          //       'Delete?',
                          //       style: TextStyle(color: ColorConstant.colorTitle),
                          //     ),
                          //     content: const Text(
                          //       'Are you sure to delete this Note?',
                          //       style: TextStyle(color: ColorConstant.colorTitle),
                          //     ),
                          //     actions: <Widget>[
                          //       TextButton(
                          //         onPressed: () =>
                          //             Navigator.pop(context, 'Cancel'),
                          //         // _showAlertDialog(context),
                          //         child: const Text('Cancel'),
                          //       ),
                          //       TextButton(
                          //         onPressed: () async {
                          //           await db.deleteNote(Note(
                          //               id: widget.id,
                          //               title: widget.title,
                          //               content: widget.content,
                          //               createDate: (widget.createDate),
                          //               isChecked: widget.isChecked));
                          //           Navigator.push(
                          //               context,
                          //               MaterialPageRoute(
                          //                   builder: (context) => NotePage()));
                          //         },
                          //         child: const Text('OK'),
                          //       ),
                          //     ],
                          //   ),
                          // );
                          _showAlertDialogDelete(context);
                        },
                        child: Text('Delete'),
                      );
                    }))),
            Container(
                width: width * 0.25,
                padding: EdgeInsets.all(10),
                child: Theme(
                    data: ThemeData(
                        dialogBackgroundColor: ColorConstant.colorSave),
                    child: Builder(builder: (context) {
                      return FlatButton(
                        color: ColorConstant.colorSave,
                        onPressed: () {
                          FocusManager.instance.primaryFocus?.unfocus();
                          // showDialog<String>(
                          //   barrierColor: Colors.transparent,
                          //   context: context,
                          //   builder: (BuildContext context) => AlertDialog(
                          //     title: const Text(
                          //       'Edit?',
                          //       style: TextStyle(color: ColorConstant.colorTitle),
                          //     ),
                          //     content: const Text(
                          //       'Are you sure to edit this Note?',
                          //       style: TextStyle(color: ColorConstant.colorTitle),
                          //     ),
                          //     actions: <Widget>[
                          //       TextButton(
                          //         onPressed: () =>
                          //             Navigator.pop(context, 'Cancel'),
                          //         child: const Text('Cancel'),
                          //       ),
                          //       TextButton(
                          //         onPressed: () async {
                          //           await db.upgradeNote(Note(
                          //               id: widget.id,
                          //               title: myController.text,
                          //               content: myControllerContent.text,
                          //               createDate: widget.createDate,
                          //               isChecked: widget.isChecked));
                          //           Navigator.push(
                          //               context,
                          //               MaterialPageRoute(
                          //                   builder: (context) => NotePage()));
                          //           print(db.getAllNote());
                          //         },
                          //         child: const Text('OK'),
                          //       ),
                          //     ],
                          //   ),
                          // );
                          // Timer(Duration(seconds: 1), () {
                          //     _showAlertDialogSave(context);
                          // });
                          _showAlertDialogSave(context);
                        },
                        child: Text(
                          'Save',
                          style: TextStyle(color: Colors.white),
                        ),
                      );
                    }))),
          ],
        ),
        body: Container(
          padding: EdgeInsets.all(20),
          width: width,
          height: height,
          color: ColorConstant.primaryColor,
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: TextField(
                  controller: myController,
                  maxLines: 1,
                  style:
                      TextStyle(fontSize: 30, color: ColorConstant.colorTitle),
                  decoration: new InputDecoration.collapsed(
                      hintText: 'Title',
                      hintStyle: TextStyle(color: ColorConstant.colorTitle)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: TextField(
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  controller: myControllerContent,
                  style: TextStyle(
                      fontSize: 20, color: ColorConstant.colorContent),
                  decoration: new InputDecoration.collapsed(
                      hintText: 'Type something ...',
                      hintStyle: TextStyle(color: ColorConstant.colorContent)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
