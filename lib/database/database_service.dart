import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:tick_tock/utils/database.dart';
import 'package:tick_tock/models/category.dart';
import 'package:tick_tock/models/to_do_item.dart';

class DatabaseService {
  //PRIVATE METHOD GET DATABASE
  static Future<Database> _getDatabase() async {
    final path = await getDatabasesPath();
    final fullPath = join(path, databaseName);
    return await openDatabase(
      fullPath,
      version: databaseVersion,
      onCreate: (db, version) async {
        //CATEGORIES
        await db.execute('''
          CREATE TABLE $categoryTableName(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            icon TEXT NOT NULL,
            name TEXT NOT NULL,
            color TEXT NOT NULL,
          )
        ''');
        //TODOITEMS
        await db.execute('''
          CREATE TABLE $toDoItemTableName(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT NOT NULL,
            reminderTime INTEGER NOT NULL,
            repeatOption TEXT,
            startTime INTEGER,
            endTime INTEGER,
            isImportant INTEGER NOT NULL,
            categoryId INTEGER,
            description TEXT
            isCompleted INTEGER NOT NULL,
            FOREIGN KEY (categoryId) REFERENCES Categories(id)
          )
        ''');
      },
    );
  }

  //ADD CATEGORY TO DATABASE
  static Future<int> addCategory(Category category) async {
    final Database db = await _getDatabase();
    return await db.insert(
      categoryTableName,
      category.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  //UPDATE CATEGORY WITH THE SAME ID
  static Future<int> updateCategory(Category category) async {
    final Database db = await _getDatabase();
    return await db.update(
      categoryTableName,
      category.toMap(),
      where: 'id = ?',
      whereArgs: [category.id],
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  //DELETE CATEGORY WITH THE SAME ID
  static Future<int> deleteCategory(Category category) async {
    final Database db = await _getDatabase();
    return await db
        .delete(categoryTableName, where: 'id = ?', whereArgs: [category.id]);
  }

  //GET ALL THE AVAILABLE CATEGORIES
  static Future<List<Category>?> getAllCategories() async {
    final Database db = await _getDatabase();
    const orderBy = "name ASC";

    final List<Map<String, dynamic>> maps =
        await db.query(categoryTableName, orderBy: orderBy);
    if (maps.isNotEmpty) {
      return List.generate(
        maps.length,
        (index) => Category.fromMap(maps[index]),
      );
    } else {
      return null;
    }
  }

  //ADD TODOITEM TO DATABASE
  static Future<int> addToDoItem(ToDoItem toDoItem) async {
    final Database db = await _getDatabase();
    return await db.insert(
      toDoItemTableName,
      toDoItem.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  //UPDATE TODOITEM WITH THE SAME ID
  static Future<int> updateToDoItem(ToDoItem toDoItem) async {
    final db = await _getDatabase();
    return await db.update(
      toDoItemTableName,
      toDoItem.toMap(),
      where: 'id = ?',
      whereArgs: [toDoItem.id],
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  //DELETE TODOITEM WITH THE SAME ID
  static Future<int> deleteToDoItem(ToDoItem toDoItem) async {
    final db = await _getDatabase();
    return await db
        .delete(toDoItemTableName, where: 'id = ?', whereArgs: [toDoItem.id]);
  }

  //GET ALL THE AVAILABLE TODOITEMS
  static Future<List<ToDoItem>?> getAllToDoItems({
    String orderBy = 'title ASC',
  }) async {
    final db = await _getDatabase();

    final List<Map<String, dynamic>> maps =
        await db.query(toDoItemTableName, orderBy: orderBy);
    if (maps.isNotEmpty) {
      return List.generate(
        maps.length,
        (index) => ToDoItem.fromMap(maps[index]),
      );
    } else {
      return null;
    }
  }

  //GET SPECIFIC TODOITEM WITH ID
  static Future<ToDoItem> getToDoItemById(int toDoItemId) async {
    final db = await _getDatabase();

    final List<Map<String, dynamic>> maps = await db
        .query(toDoItemTableName, where: 'id = ?', whereArgs: [toDoItemId]);
    if (maps.isNotEmpty) {
      return ToDoItem.fromMap(maps.first);
    } else {
      throw Exception('ID $toDoItemId not found');
    }
  }
}
