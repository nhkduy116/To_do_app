// ignore_for_file: prefer_const_constructors, unnecessary_import, implementation_imports, deprecated_member_use, unused_import

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:to_do_list/Widget_Component/note_list.dart';
import 'package:to_do_list/Widget_Component/widget_component.dart';
import 'package:to_do_list/constant/color_constant.dart';
import 'package:to_do_list/page/add_note_page.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class NotePage extends StatefulWidget {
  const NotePage({Key? key}) : super(key: key);

  @override
  State<NotePage> createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery. of(context). size. width ;
    double height = MediaQuery. of(context). size. height;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: ColorConstant.primaryColor,
        elevation: 0,
        title: Text('Notes', style: TextStyle(fontSize: 28), textAlign: TextAlign.center,),
        automaticallyImplyLeading: false,
        actions: <Widget>[
          Container(
            // padding: EdgeInsets.all(15),
            child: GestureDetector(
              onTap: (() {
                
              }),
              child: Icon(Icons.search, color: Colors.white, size: 25,),
              ),
          )
        ],
      ),
      body: Container(
        width: width,
        height: height,
        color: ColorConstant.primaryColor,
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
          children: <Widget>[
            StaggeredGrid.count(
              crossAxisCount: 4,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              children: [
                NoteList()
              ],
            ),
          ],
        ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => AddNote()));
        },
        backgroundColor: ColorConstant.colorFloatingActionButton,
        child: Icon(Icons.add),),
    );
  }
}