import "package:path/path.dart";
import "package:sqflite/sqflite.dart";
import "package:tick_tock/core/constants/database.dart";
import "package:tick_tock/features/category/domain/category.dart";
import "package:tick_tock/features/to_do/domain/to_do.dart";

class DatabaseService {
  //PRIVATE METHOD GET DATABASE
  static Future<Database> _getDatabase() async {
    final path = await getDatabasesPath();
    final fullPath = join(path, databaseName);
    return openDatabase(
      fullPath,
      version: databaseVersion,
      onCreate: (final db, final version) async {
        //CATEGORIES
        await db.execute("""
          CREATE TABLE $categoryTableName(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            icon TEXT NOT NULL,
            name TEXT NOT NULL,
            color TEXT NOT NULL
          )
        """);
        //TODOITEMS
        await db.execute("""
          CREATE TABLE $toDoItemTableName(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT NOT NULL,
            reminderTime INTEGER NOT NULL,
            repeatOption TEXT,
            startTime TEXT,
            endTime TEXT,
            isImportant INTEGER NOT NULL,
            categoryId INTEGER,
            description TEXT,
            isCompleted INTEGER NOT NULL,
            createdTime TEXT NOT NULL,
            FOREIGN KEY (categoryId) REFERENCES Categories(id)
          )
        """);
      },
    );
  }

  //ADD CATEGORY TO DATABASE
  static Future<int> addCategory(final Category category) async {
    final Database db = await _getDatabase();
    return db.insert(
      categoryTableName,
      category.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  //UPDATE CATEGORY WITH THE SAME ID
  static Future<int> updateCategory(final Category category) async {
    final Database db = await _getDatabase();
    return db.update(
      categoryTableName,
      category.toMap(),
      where: "id = ?",
      whereArgs: [category.id],
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  //DELETE CATEGORY WITH THE SAME ID
  static Future<int> deleteCategory(final Category category) async {
    final Database db = await _getDatabase();
    return db
        .delete(categoryTableName, where: "id = ?", whereArgs: [category.id]);
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
        (final index) => Category.fromMap(maps[index]),
      );
    } else {
      return null;
    }
  }

  //ADD TODOITEM TO DATABASE
  static Future<int> addToDo(final ToDo toDoItem) async {
    final Database db = await _getDatabase();
    return db.insert(
      toDoItemTableName,
      toDoItem.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  //UPDATE TODOITEM WITH THE SAME ID
  static Future<int> updateToDo(final ToDo toDoItem) async {
    final db = await _getDatabase();
    return db.update(
      toDoItemTableName,
      toDoItem.toMap(),
      where: "id = ?",
      whereArgs: [toDoItem.id],
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  //DELETE TODOITEM WITH THE SAME ID
  static Future<int> deleteToDo(final ToDo toDoItem) async {
    final db = await _getDatabase();
    return db
        .delete(toDoItemTableName, where: "id = ?", whereArgs: [toDoItem.id]);
  }

  //GET ALL THE AVAILABLE TODOITEMS
  static Future<List<ToDo>?> getAllToDos({
    final String orderBy = "title ASC",
  }) async {
    final db = await _getDatabase();

    final List<Map<String, dynamic>> maps =
        await db.query(toDoItemTableName, orderBy: orderBy);
    if (maps.isNotEmpty) {
      return List.generate(
        maps.length,
        (final index) => ToDo.fromMap(maps[index]),
      );
    } else {
      return null;
    }
  }

  //GET SPECIFIC TODOITEM WITH ID
  static Future<ToDo> getToDoById(final int toDoItemId) async {
    final db = await _getDatabase();

    final List<Map<String, dynamic>> maps = await db
        .query(toDoItemTableName, where: "id = ?", whereArgs: [toDoItemId]);
    if (maps.isNotEmpty) {
      return ToDo.fromMap(maps.first);
    } else {
      throw Exception("ID $toDoItemId not found");
    }
  }

  //UPDATE COMPLETE FOR TODOITEM
  static Future<int> updateToDoComplete(
    final int toDoItemId,
    final int isCompleted,
  ) async {
    final db = await _getDatabase();
    return db.update(
      toDoItemTableName,
      {"isCompleted": isCompleted},
      where: "id=?",
      whereArgs: [toDoItemId],
    );
  }
}
