class Note {
  int? id;
  String title;
  String content;
  DateTime createDate;
  bool isChecked;
  
  Note({
    this.id,
    required this.title,
    required this.content,
    required this.createDate,
    required this.isChecked,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'createDate': createDate.toString(),
      'isChecked': isChecked ? 1 : 0,
    };
  }

  @override
  String toString() {
    // ignore: todo
    // TODO: implement toString
    return 'Todo(id: $id, title: $title, content: $content, createDate: $createDate, isChecked: $isChecked';
  }
}