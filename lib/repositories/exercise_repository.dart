import 'package:sqflite/sqflite.dart';
import 'package:workout_app/logging/logger.dart';
import 'package:workout_app/models/exercise/exercise.dart';
import 'package:workout_app/models/exercise/exercise_exercise_tag_junction.dart';
import 'package:workout_app/models/exercise/exercise_tag.dart';
import 'package:workout_app/models/exercise_set/exercise_rep.dart';
import 'package:workout_app/models/exercise_set/exercise_set.dart';
import 'package:workout_app/repositories/exercise_seeding.dart';

class ExerciseRepository {
  ExerciseRepository() {
    // try {
    //   Logger.debug("Deleting database...");
    //   _getDatabasePath().then((value) {
    //     deleteDatabase(value);
    //     Logger.debug("Database deleted!");
    //   });
    // } catch (e) {
    //   Logger.error("Deletion of database failed", e);
    // }
  }

  Future<List<Exercise>> getExercises() async {
    Logger.debug("Getting all exercises...");

    String getAllExercisesQuery = '''
      SELECT
          e.${Exercise.idColumn}            AS ${Exercise.idColumn},
          e.${Exercise.nameColumn}          AS ${Exercise.nameColumn},
          e.${Exercise.descriptionColumn}   AS ${Exercise.descriptionColumn},
          t.${ExerciseTag.idColumn}         AS ${ExerciseTag.idColumn},
          t.${ExerciseTag.tagColumn}        AS ${ExerciseTag.tagColumn}
      FROM ${Exercise.tableName} e
      LEFT JOIN ${ExerciseExerciseTagJunction.tableName} eet 
             ON eet.${Exercise.idColumn} = e.${Exercise.idColumn}
      LEFT JOIN ${ExerciseTag.tableName} t 
             ON t.${ExerciseTag.idColumn} = eet.${ExerciseTag.idColumn}
    ''';

    final rows = await _queryDatabase(getAllExercisesQuery);

    final Map<int, Exercise> exerciseMap = {};

    for (final row in rows) {
      final int exerciseId = row[Exercise.idColumn] as int;

      // Create exercise once
      exerciseMap.putIfAbsent(
        exerciseId,
        () => Exercise(
          id: exerciseId,
          name: row[Exercise.nameColumn] as String,
          description: row[Exercise.descriptionColumn] as String,
          tags: [],
        ),
      );

      // Add tag if present
      final tag = row[ExerciseTag.tagColumn];
      if (tag != null) {
        exerciseMap[exerciseId]!.tags!.add(tag as String);
      }
    }

    final exercises = exerciseMap.values.toList();

    Logger.debug(
      "Got all exercises: ${exercises.map((e) => e.name).join(", ")}",
    );
    return exercises;
  }

  Future<Exercise> getExercise(String exerciseId) {
    return Future.value(
      Exercise(id: -1, name: "N/A", description: "N/A", tags: []),
    );
  }

  Future<bool> setExercise(Exercise exercise) {
    return Future.value(false);
  }

  Future<List<ExerciseRep>> getRepData(String exerciseId) {
    return Future.value([]);
  }

  Future<bool> insertExerciseSetData(ExerciseSet set) async {
    Logger.debug("Inserting ");
    try {
      Database db = await _openDatabase();

      String insertExerciseSetQuery = '''
      INSERT INTO ExerciseSet(exercise_id, order_index)
      VALUES (?, ?)
      ''';

      final exerciseSetId = await db.rawInsert(
        insertExerciseSetQuery,
        [set.exercise.id, set.orderIndex],
      );

      return false;


    } on DatabaseException catch (e) {
      printDatabaseException(e);
      return Future.value(false);
    } catch (e) {
      Logger.error(
        "An error happened while inserting exercise-exercise-tag into database",
        e,
      );
      return Future.value(false);
    }
  }

  static Future<void> _createExerciseTable(Database db) async {
    Logger.debug("Creating database tables for Exercises...");

    Logger.debug("Creating exercise table...");
    String createExerciseTableQuery = '''
    CREATE TABLE ${Exercise.tableName} (
        ${Exercise.idColumn} INTEGER PRIMARY KEY AUTOINCREMENT,
        ${Exercise.nameColumn} TEXT NOT NULL,
        ${Exercise.descriptionColumn} TEXT NOT NULL
    );
    ''';
    createExerciseTableQuery.trim();

    await db.execute(createExerciseTableQuery);

    Logger.debug("Created!");

    Logger.debug("Creating exercise-tag table...");

    String createExerciseTagTableQuery = '''
    CREATE TABLE ${ExerciseTag.tableName} (
        ${ExerciseTag.idColumn} INTEGER PRIMARY KEY AUTOINCREMENT,
        ${ExerciseTag.tagColumn} TEXT NOT NULL
    );
    ''';
    createExerciseTagTableQuery.trim();

    await db.execute(createExerciseTagTableQuery);

    Logger.debug("Created!");

    Logger.debug("Creating exercise exercise-tag junction table...");

    String createExerciseTagJunctionTableQuery = '''
    CREATE TABLE ${ExerciseExerciseTagJunction.tableName} (
        ${Exercise.idColumn} INTEGER NOT NULL,
        ${ExerciseTag.idColumn} INTEGER NOT NULL,
        PRIMARY KEY (${Exercise.idColumn}, ${ExerciseTag.idColumn}),
        FOREIGN KEY (${Exercise.idColumn}) REFERENCES ${Exercise.tableName}(${Exercise.idColumn}) ON DELETE CASCADE,
        FOREIGN KEY (${ExerciseTag.idColumn}) REFERENCES ${ExerciseTag.tableName}(${ExerciseTag.idColumn}) ON DELETE CASCADE
    );
    ''';
    createExerciseTagJunctionTableQuery.trim();

    await db.execute(createExerciseTagJunctionTableQuery);

    Logger.debug("Created!");

    Logger.debug("Created exercise tables!");
  }

  static Future<void> _createExerciseSetTable(Database db) async {
    Logger.debug("Creating database tables for rep entries...");

    Logger.debug("Creating exercise set table...");
    String createExerciseSetTableQuery = '''
    CREATE TABLE ${ExerciseSet.tableName} (
        ${ExerciseSet.idColumn} INTEGER PRIMARY KEY AUTOINCREMENT,
        ${Exercise.idColumn} INTEGER NOT NULL,
        ${ExerciseSet.orderIndexColumn} INTEGER NOT NULL,
        FOREIGN KEY (${Exercise.idColumn})
            REFERENCES ${Exercise.tableName}(${Exercise.idColumn})
            ON DELETE CASCADE
    );
    ''';
    createExerciseSetTableQuery.trim();

    await db.execute(createExerciseSetTableQuery);

    Logger.debug("Created!");
    Logger.debug("Creating exercise rep table...");

    String createRepEntryTableQuery = '''
    CREATE TABLE ${ExerciseRep.tableName} (
        ${ExerciseRep.idColumn} INTEGER PRIMARY KEY AUTOINCREMENT,
        ${ExerciseSet.idColumn} INTEGER NOT NULL,
        ${ExerciseRep.repsColumn} INTEGER NOT NULL,
        ${ExerciseRep.weightColumn} REAL NOT NULL,
        ${ExerciseRep.weightUnitColumn} INTEGER NOT NULL,
        ${ExerciseRep.isWarmUpColumn} INTEGER NOT NULL CHECK (${ExerciseRep.isWarmUpColumn} IN (0,1)),
        ${ExerciseRep.orderIndexColumn} INTEGER NOT NULL,
        FOREIGN KEY (${ExerciseSet.idColumn})
            REFERENCES ${ExerciseSet.tableName}(${ExerciseSet.idColumn})
            ON DELETE CASCADE
    );
    ''';
    createRepEntryTableQuery.trim();

    await db.execute(createRepEntryTableQuery);

    Logger.debug("Created!");

    Logger.debug("Database tables created for rep entries");
  }

  Future<int> _insertExerciseIntoDatabase(
    Exercise exercise,
    Database db,
  ) async {
    try {
      String query = """
        INSERT INTO 
          ${Exercise.tableName}(
            ${Exercise.idColumn}, 
            ${Exercise.nameColumn}, 
            ${Exercise.descriptionColumn}) 
          VALUES(
            '${exercise.id}', 
            '${exercise.name}', 
            '${exercise.description}')
      """;
      query.trim();

      Logger.debug("Inserting exercise...");

      var id = await db.rawInsert(query);

      Logger.debug("Inserted with return value $id");

      return id;
    } catch (e) {
      Logger.error(
        "An error happened while inserting exercise into database",
        e,
      );
      return Future.value(-1);
    }
  }

  Future<int> _insertExerciseTagIntoDatabase(
    ExerciseTag tag,
    Database db,
  ) async {
    try {
      String query = """
        INSERT INTO 
          ${ExerciseTag.tableName}(
            ${ExerciseTag.idColumn}, 
            ${ExerciseTag.tagColumn}) 
          VALUES(
            '${tag.id}', 
            '${tag.tag}')
      """;
      query.trim();

      Logger.debug("Inserting exercise tag...");

      var id = await db.rawInsert(query);

      Logger.debug("Inserted with return value $id");

      return id;
    } catch (e) {
      Logger.error(
        "An error happened while inserting exercise tag into database",
        e,
      );
      return Future.value(-1);
    }
  }

  Future<int> _insertExerciseExerciseTagJunctionIntoDatabase(
    ExerciseExerciseTagJunction junction,
    Database db,
  ) async {
    try {
      String query = """
        INSERT INTO 
          ${ExerciseExerciseTagJunction.tableName}(
            ${Exercise.idColumn}, 
            ${ExerciseTag.idColumn}) 
          VALUES(
            '${junction.exerciseId}', 
            '${junction.exerciseTagId}')
      """;
      query.trim();

      Logger.debug(
        "Inserting exercise-exercise-tag ${junction.exerciseId} : ${junction.exerciseTagId}",
      );

      var id = await db.rawInsert(query);

      Logger.debug("Inserted with return value $id");

      return id;
    } on DatabaseException catch (e) {
      printDatabaseException(e);
      return Future.value(-1);
    } catch (e) {
      Logger.error(
        "An error happened while inserting exercise-exercise-tag into database",
        e,
      );
      return Future.value(-1);
    }
  }

  Future<String> _getDatabasePath() async {
    var databasesPath = await getDatabasesPath();
    databasesPath = '${databasesPath}workout_app.db';
    Logger.debug("Created database path: $databasesPath");
    return databasesPath;
  }

  Future<Database> _openDatabase() async {
    return openDatabase(
      await _getDatabasePath(),
      version: 1,
      onCreate: _createDatabase,
    );
  }

  Future<void> _createDatabase(Database db, int version) async {
    try {
      Logger.debug("Creating database first time...");

      // Ensure database has correct tables
      await _createExerciseTable(db);
      await _createExerciseSetTable(db);

      // Fill database with predefined exercises
      await _seedDatabase(db);
    } catch (e) {
      Logger.error("An error happened initializing the database: $e", e);
    }
  }

  Future<void> _seedDatabase(Database db) async {
    Logger.debug("Seeding database...");

    await db.transaction((txn) async {
      // Exercises
      for (final exercise in ExerciseSeeding.exercises) {
        await txn.insert(Exercise.tableName, {
          Exercise.idColumn: exercise.id,
          Exercise.nameColumn: exercise.name,
          Exercise.descriptionColumn: exercise.description,
        }, conflictAlgorithm: ConflictAlgorithm.ignore);
      }

      // Tags
      for (final tag in ExerciseSeeding.exerciseTags) {
        await txn.insert(ExerciseTag.tableName, {
          ExerciseTag.idColumn: tag.id,
          ExerciseTag.tagColumn: tag.tag,
        }, conflictAlgorithm: ConflictAlgorithm.ignore);
      }

      // Junctions
      for (final junction in ExerciseSeeding.exerciseExerciseTagJunctions) {
        await txn.insert(
          ExerciseExerciseTagJunction.tableName,
          {
            Exercise.idColumn: junction.exerciseId,
            ExerciseTag.idColumn: junction.exerciseTagId,
          },
          conflictAlgorithm: ConflictAlgorithm.ignore,
        );
      }
    });
    // Count exercises
    final exerciseCountResult = await db.rawQuery(
      'SELECT COUNT(*) AS count FROM ${Exercise.tableName};',
    );
    final int exerciseCount = Sqflite.firstIntValue(exerciseCountResult) ?? 0;
    Logger.debug("Seeded $exerciseCount exercises. Expected 16");

    // Count tags
    final tagCountResult = await db.rawQuery(
      'SELECT COUNT(*) AS count FROM ${ExerciseTag.tableName};',
    );
    final int tagCount = Sqflite.firstIntValue(tagCountResult) ?? 0;
    Logger.debug("Seeded $tagCount exercise tags. Expexted 32");

    // Count junction rows
    final junctionCountResult = await db.rawQuery(
      'SELECT COUNT(*) AS count FROM ${ExerciseExerciseTagJunction.tableName};',
    );
    final int junctionCount = Sqflite.firstIntValue(junctionCountResult) ?? 0;
    Logger.debug(
      "Seeded $junctionCount exercise-exerciseTag junctions. Expected > 80",
    );

    if (junctionCount > 80 && tagCount == 32 && exerciseCount == 16) {
      Logger.debug("Database seeded successfully!");
      return;
    }

    Logger.error("Seeding of database went wrong", Object());
  }

  Future<List<Map<String, Object?>>> _queryDatabase(String query) async {
    // try {
    query.trim();

    Database db = await _openDatabase();

    List<Map<String, Object?>> result = await db.rawQuery(query);

    db.close();

    return result;
    // } catch (e) {
    // Logger.error("An error happened quering database!", e);
    // return Future.value(List.of([]));
    // }
  }

  void printDatabaseException(DatabaseException e) {
    String message = "";

    if (e.isDatabaseClosedError()) {
      message = "Database is closed!";
    } else if (e.isDuplicateColumnError()) {
      message = "Duplicate column!";
    } else if (e.isNoSuchTableError()) {
      message = "No such table!";
    } else if (e.isNotNullConstraintError()) {
      message = "A not null was not respected!";
    } else if (e.isOpenFailedError()) {
      message = "Open failed!";
    } else if (e.isReadOnlyError()) {
      message = "Read only error";
    } else if (e.isSyntaxError()) {
      message = "Syntax error!";
    } else if (e.isUniqueConstraintError()) {
      message = "A unique was not respected!";
    } else {
      message = e.result.toString();
    }

    Logger.error(message, e);
  }
}
