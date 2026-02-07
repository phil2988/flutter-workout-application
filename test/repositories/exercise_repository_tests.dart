import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite/sqflite.dart';
import 'package:workout_app/logging/logger.dart';
import 'package:workout_app/models/exercise/exercise.dart';
import 'package:workout_app/repositories/exercise_repository.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  ExerciseRepository? uut;
  Database? testDb;

  setUp(() async {
    uut = ExerciseRepository();
    testDb = await openDatabase(
      inMemoryDatabasePath,
      version: 1,
      onCreate: (db, version) async {
        Logger.debug("Creating in-memory database for testing");
      },
    );
  });

  test('getDatabasePath should return the correct path', () async {
    var result = await uut?.getDatabasePathForTest();
    expect(result, isNotNull);
    expect(result, contains(ExerciseRepository.databaseName));
  });

  test("getDatabase should return a non-null database", () async {
    var result = await uut?.getDatabaseForTest();
    expect(result, isNotNull);
    expect(result!.database, isNotNull);
    expect(result.database.path, contains(ExerciseRepository.databaseName));
  });

  test("_createExerciseTable should create the exercise table", () async {
    uut?.getCreateExerciseTableForTest(testDb!);

    var tables = await testDb?.rawQuery('''
    SELECT name
    FROM sqlite_master
    WHERE type = 'table'
    AND name = '${Exercise.tableName}';
    ''');
    expect(tables, isNotNull);
    expect(tables!.length, 1);
  });

  tearDown(() async {
    await deleteDatabase(testDb!.path);
    await testDb?.close();
  });
}
