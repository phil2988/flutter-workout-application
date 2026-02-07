import 'package:workout_app/models/exercise_set/exercise_rep.dart';
import 'package:workout_app/models/exercise_set/exercise_set.dart';
import 'package:workout_app/repositories/exercise_repository.dart';
import 'package:workout_app/models/exercise/exercise.dart';

class ExerciseServices {
  Future<List<Exercise>> getAllExercises() async {
    return ExerciseRepository().getExercises();
  }

  Future<bool> addExerciseRepData(ExerciseRep repEntry) async {
    return ExerciseRepository().insertExerciseSetData(ExerciseSet(exercise: Exercise(id: 1, name: "1", description: "1"), reps: List.empty(), id: 1, orderIndex: 2));
  }
}
