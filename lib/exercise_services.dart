import 'package:workout_app/models/exercise_set/exercise_rep.dart';
import 'package:workout_app/models/exercise_set/exercise_set.dart';
import 'package:workout_app/repositories/exercise_repository.dart';
import 'package:workout_app/models/exercise/exercise.dart';

class ExerciseServices {
  Future<List<Exercise>> getAllExercises() async {
    return ExerciseRepository().getExercises();
  }

  Future<bool> addExerciseSetData(ExerciseSet exerciseSet) async {
    return ExerciseRepository().insertExerciseSetData(exerciseSet);
  }

  Future<List<ExerciseRep>> getNewestExerciseSetData(int id) async {
    return Future.value([
      ExerciseRep(id: 0, reps: 10, weight: 22.5, orderIndex: 0),
      ExerciseRep(id: 1, reps: 8, weight: 22.5, orderIndex: 1),
      ExerciseRep(id: 2, reps: 7, weight: 22.5, orderIndex: 2),
    ]);
  }
}
