import 'package:workout_app/models/exercise/exercise.dart';
import 'package:workout_app/models/exercise/exercise_tag.dart';

class ExerciseExerciseTagJunction {
  static final String tableName = "ExerciseExerciseTagJunctionTable";

  ExerciseExerciseTagJunction({
    required this.exerciseId,
    required this.exerciseTagId,
  });

  final int exerciseId;
  final int exerciseTagId;

  factory ExerciseExerciseTagJunction.fromMap(Map<String, Object?> map) {
    return ExerciseExerciseTagJunction(
      exerciseId: map[Exercise.idColumn] as int,
      exerciseTagId: map[ExerciseTag.idColumn] as int,
    );
  }
}
