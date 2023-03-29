// ignore_for_file: prefer_const_constructors, deprecated_member_use, prefer_const_literals_to_create_immutables, unnecessary_new, unnecessary_import, implementation_imports, prefer_interpolation_to_compose_strings, unused_import, unused_local_variable
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:to_do_list/constant/color_constant.dart';
import 'package:to_do_list/database/notes_database.dart';
import 'package:to_do_list/page/note_page.dart';
import 'package:to_do_list/model/note.dart';
import 'package:intl/intl.dart';
import 'dart:math';

class AddNote extends StatefulWidget {
  const AddNote({Key? key}) : super(key: key);

  @override
  State<AddNote> createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  final myController = TextEditingController();
  final myControllerContent = TextEditingController();
  late var db = DatabaseConnect();
  final now = new DateTime.now();
  static var id = 0;
  // String formatter = DateFormat.yMMMMd('en_US').format(now);
  @override
  void dispose() {
    myController.dispose();
    myControllerContent.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    Random rdn = new Random();
    return GestureDetector(
      onTap: (() {
        FocusManager.instance.primaryFocus?.unfocus();
      }),
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
                padding: EdgeInsets.all(10),
                child: GestureDetector(
                    onTap: () async {
                      if (myController.text == "" ||
                          myControllerContent.text == "") {
                        showDialog(
                          barrierColor: Colors.transparent,
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                                backgroundColor: ColorConstant.colorSave,
                                content: Text(
                                  'Please complete all information',
                                  style: TextStyle(
                                      color: ColorConstant.colorTitle),
                                ));
                          },
                        );
                      } else {
                        FocusManager.instance.primaryFocus?.unfocus();
                        await db.insertNote(Note(
                            id: id,
                            title: myController.text,
                            content: myControllerContent.text,
                            createDate: now,
                            isChecked: false));
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => NotePage()));
                        id++;
                      }
                    },
                    child: Text(
                      'Save',
                      style: TextStyle(color: Colors.white),
                    )),
              )
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
                    style: TextStyle(
                        fontSize: 30, color: ColorConstant.colorTitle),
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
                        hintStyle:
                            TextStyle(color: ColorConstant.colorContent)),
                  ),
                )
              ],
            ),
          )),
    );
  }
}
