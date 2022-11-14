// ignore_for_file: must_be_immutable, unused_element

import 'package:flutter/material.dart';
import 'package:to_do_list/constant/color_constant.dart';
import '../database/notes_database.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'widget_component.dart';
import 'dart:math';

class NoteList extends StatelessWidget {
  var db = DatabaseConnect();
  NoteList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final rnd = new Random();
  int next(int min, int max) => min + rnd.nextInt(max - min);
    return StaggeredGridTile.count(
      crossAxisCellCount: 4,
      mainAxisCellCount: 8,
      child: FutureBuilder(
        future: db.getAllNote(),
        initialData: const [],
        builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
          var data = snapshot.data;
          var dataLength = data!.length;
          return dataLength == 0
              ? Center(
                  child: Text('No data found', style: TextStyle(fontSize: 16, color: ColorConstant.colorTitle),),
                )
              : ListView.builder(
                  itemCount: dataLength,
                  reverse: false,
                  itemBuilder: (context, i) => NoteBox(
                    id: data[i].id,
                    title: data[i].title,
                    content: data[i].content,
                    createDate: data[i].createDate,
                    isChecked: data[i].isChecked
                  )
                );
        },
      ),
    );
  }
}
