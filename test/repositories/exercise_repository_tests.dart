import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite/sqflite.dart';
import 'package:workout_app/models/exercise/exercise.dart';
import 'package:workout_app/models/exercise/exercise_exercise_tag_junction.dart';
import 'package:workout_app/models/exercise/exercise_tag.dart';
import 'package:workout_app/models/exercise_set/exercise_rep.dart';
import 'package:workout_app/models/exercise_set/exercise_set.dart';
import 'package:workout_app/repositories/exercise_repository.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  ExerciseRepository? uut;
  Database? testDb;

  setUp(() async {
    uut = ExerciseRepository();
    testDb = await openDatabase(inMemoryDatabasePath, version: 1, onCreate: (db, version) async {});
  });

  test('_getDatabasePath should return the correct path', () async {
    // Arrange

    // Act
    var result = await uut?.testGetDatabasePath();

    // Assert
    expect(result, isNotNull);
    expect(result, contains("/data/user/0/com.example.workout_app/databases/${ExerciseRepository.databaseName}"));
  });

  test("_openDatabase should return a non-null database", () async {
    // Arrange

    // Act
    var result = await uut?.testOpenDatabase();

    // Assert
    expect(result, isNotNull);
    expect(result!.database, isNotNull);
    expect(result.database.path, contains(ExerciseRepository.databaseName));
  });

  test("_createExerciseTable should create the exercise table", () async {
    // Arrange

    // Act
    uut?.testCreateExerciseTable(testDb!);

    // Assert
    var exerciseTable = await getTableFromDb(testDb!, Exercise.tableName);

    expect(exerciseTable, isNotNull);
    expect(exerciseTable!.length, 1);

    var exerciseTagTable = await getTableFromDb(testDb!, ExerciseTag.tableName);

    expect(exerciseTagTable, isNotNull);
    expect(exerciseTagTable!.length, 1);

    var exerciseExerciseTagJunctionTable = await getTableFromDb(testDb!, ExerciseExerciseTagJunction.tableName);

    expect(exerciseExerciseTagJunctionTable, isNotNull);
    expect(exerciseExerciseTagJunctionTable!.length, 1);
  });

  test("_createExerciseSetTable should create the ExerciseSet table", () async {
    // Arrange

    // Act
    uut?.testCreateExerciseSetTable(testDb!);

    // Assert
    var exerciseSetTable = await getTableFromDb(testDb!, ExerciseSet.tableName);

    expect(exerciseSetTable, isNotNull);
    expect(exerciseSetTable!.length, 1);

    var exerciseRepTable = await getTableFromDb(testDb!, ExerciseRep.tableName);

    expect(exerciseRepTable, isNotNull);
    expect(exerciseRepTable!.length, 1);
  });

  test("_seedDatabase should seed the database", () async {
    // Arrange
    await uut!.testCreateExerciseTable(testDb!);

    // Act
    await uut!.testSeedDatabase(testDb!);

    // Assert
    // Count exercises
    final exerciseCountResult = await testDb!.rawQuery('''
      SELECT COUNT(*) AS count FROM ${Exercise.tableName};
    ''');
    final int exerciseCount = Sqflite.firstIntValue(exerciseCountResult) ?? 0;
    expect(exerciseCount, 16);

    // Count tags
    final tagCountResult = await testDb!.rawQuery('''
      SELECT COUNT(*) AS count FROM ${ExerciseTag.tableName};
    ''');
    final int tagCount = Sqflite.firstIntValue(tagCountResult) ?? 0;
    expect(tagCount, 32);

    // Count junctions
    final junctionCountResult = await testDb!.rawQuery('''
      SELECT COUNT(*) AS count FROM ${ExerciseExerciseTagJunction.tableName};
    ''');
    final int junctionCount = Sqflite.firstIntValue(junctionCountResult) ?? 0;
    expect(junctionCount, 83);
  });

  tearDown(() async {
    await deleteDatabase(testDb!.path);
    await testDb?.close();
  });
}

Future<List<Map<String, Object?>>?> getTableFromDb(Database db, String tableName) async {
  return db.rawQuery('''
    SELECT name
    FROM sqlite_master
    WHERE type = 'table'
    AND name = '$tableName';
    ''');
}
