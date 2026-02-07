import 'package:workout_app/models/exercise/exercise.dart';
import 'package:workout_app/models/exercise_set/exercise_rep.dart';

class ExerciseSet {
  static final String tableName = "ExerciseSet";
  static final String idColumn = "exercise_set_id";
  static final String exerciseColumn = Exercise.idColumn;
  static final String exerciseRepsColumn = "exercise_reps";
  static final String orderIndexColumn = "exercise_order_index";

  ExerciseSet({
    required this.exercise,
    required this.reps,
    required this.id,
    required this.orderIndex,
  });

  final int id;
  final Exercise exercise;
  final List<ExerciseRep> reps;
  final int orderIndex; // Usefull for when an exercise will be integrated into a workout later
}
