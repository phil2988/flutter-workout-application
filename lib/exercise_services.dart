import 'package:workout_app/exercise_repository.dart';
import 'package:workout_app/models/exercise.dart';

class ExerciseServices {
  Future<List<Exercise>> getAllExercises() async {
    ExerciseRepository repository = await ExerciseRepository.getInstance();
    return repository.getExercises();
  }

  Future<bool> submitExerciseRepData(String exerciseId, int repCount, double weight) async {
    ExerciseRepository repository = await ExerciseRepository.getInstance();
    return repository.setExerciseRepData(exerciseId, repCount, weight);
  }
}
