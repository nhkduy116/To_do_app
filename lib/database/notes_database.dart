import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:to_do_list/model/note.dart';

class DatabaseConnect {
  Database? _database;
  Future<Database> get database async {
    final dbPath = await getDatabasesPath();
    final dbName = 'dbNote.db';
    final path = join(dbPath, dbName);

    _database = await openDatabase(path,
        version: 2, onCreate: _createDB, onUpgrade: _onUpgrade);
    return _database!;
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE table todo(
        id INTEGER PRIMARY_KEY NOT NULL,
        title TEXT,
        content TEXT,
        createDate TEXT,
        isChecked INTEGER
      )
    ''');
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < newVersion) {
      await db.execute('''
      ALTER TABLE todo ADD COLUMN content TEXT
      ''');
    }
  }

  Future<void> upgradeNote(Note note) async {
    final db = await database;
    Note noteUpdate = Note(
      id: note.id,
      title: note.title,
      content: note.content,
      createDate: note.createDate,
      isChecked: note.isChecked);
    await db.update(
        'todo',
        noteUpdate.toMap(),
        where: 'id = ?',
        whereArgs: [note.id]);
  }

  Future<void> insertNote(Note note) async {
    final db = await database;
    await db.insert('todo', note.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> deleteNote(Note note) async {
    final db = await database;
    await db.delete('todo', where: 'id == ?', whereArgs: [note.id]);
  }

  Future<List<Note>> getAllNote() async {
    final db = await database;
    List<Map<String, dynamic>> items =
        await db.query('todo', orderBy: 'id ASC');

    return List.generate(
        items.length,
        (i) => Note(
            id: items[i]['id'],
            title: items[i]['title'],
            content: items[i]['content'],
            createDate: DateTime.parse(items[i]['createDate']),
            isChecked: items[i]['isChecked'] == 1 ? true : false));
  }

  Future<List<Note>> getNoteByID(int id) async {
    final db = await database;
    List<Map<String, dynamic>> item =
        await db.query('todo', where: 'id == ?', whereArgs: [id]);

    return List.generate(
        item.length,
        (i) => Note(
            id: item[i]['id'],
            title: item[i]['title'],
            content: item[i]['content'],
            createDate: DateTime.parse(item[i]['createDate']),
            isChecked: item[i]['isChecked'] == 1 ? true : false));
  }
}
