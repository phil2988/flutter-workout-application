import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:workout_app/models/exercise.dart';
import 'package:workout_app/models/rep_entry.dart';

class ExerciseRepository {
  static ExerciseRepository? _instance;
  SharedPreferences? storage;
  static bool _hasInitialized = false;

  ExerciseRepository._() {
    // _init();
  }

  static Future<ExerciseRepository> getInstance() async {
    _instance ??= ExerciseRepository._();

    if (_instance == null) {
      print("Eror unable to initialize storage...");
    }

    return _instance!;
  }

  void _init() {
    SharedPreferences.getInstance()
        .then(
          (success) => {
            storage = success,
            if (storage != null)
              {
                storage!.setStringList(
                  "exercises",
                  _fakeExercises.map((exercise) => jsonEncode(exercise.toJson())).toList(),
                ),
              },
          },
        )
        .catchError((e) => print(e))
        .whenComplete(() {
          _hasInitialized = true;
        });
  }

  Future<List<Exercise>> getExercises() async {
    await Future.delayed(Duration(seconds: 1));

    return Future.value(_fakeExercises);

    // try {
    //   List<String> stringValue = storage?.getStringList("exercises") ?? [];
    //   List<dynamic> exercisesDynamic = stringValue.map((exerciseJsonString) => jsonDecode(exerciseJsonString)).toList();
    //   List<Exercise> exercises = exercisesDynamic as List<Exercise>;

    //   return Future.value(exercises);
    // } catch (e) {
    //   return Future.value([]);
    // }
  }

  Future<Exercise> getExercise(String exerciseId) {
    return Future.value(Exercise(id: "-1", name: "N/A", description: "N/A", tags: []));
  }

  Future<bool> setExercise(Exercise exercise) {
    return Future.value(false);
  }

  Future<List<RepEntry>> getRepData(String exerciseId) {
    return Future.value([]);
  }

  Future<bool> setExerciseRepData(String exerciseId, int repCount, double weight) {
    return Future.value(false);
  }

  final List<Exercise> _fakeExercises = <Exercise>[
    Exercise(
      id: "5",
      name: "Deadlift",
      description: "N/A",
      tags: ["Back", "Hamstrings", "Barbell", "Pull", "Legs", "Core"],
    ),
    Exercise(
      id: "6",
      name: "Overhead Press",
      description: "N/A",
      tags: ["Shoulders", "Barbell", "Press", "Push", "Delts", "Arms"],
    ),
    Exercise(
      id: "7",
      name: "Pull-Ups",
      description: "N/A",
      tags: ["Back", "Lats", "Bodyweight", "Pull", "Arms", "Core"],
    ),
    Exercise(id: "8", name: "Lat Pulldown", description: "N/A", tags: ["Back", "Lats", "Cable", "Pull", "Arms"]),
    Exercise(id: "9", name: "Leg Press", description: "N/A", tags: ["Legs", "Quads", "Glutes", "Push", "Machine"]),
    Exercise(
      id: "10",
      name: "Lunges",
      description: "N/A",
      tags: ["Legs", "Glutes", "Bodyweight", "Dumbell", "Balance", "Push"],
    ),
    Exercise(
      id: "11",
      name: "Incline Dumbbell Press",
      description: "N/A",
      tags: ["Chest", "Incline", "Dumbell", "Push", "Upper Chest"],
    ),
    Exercise(
      id: "12",
      name: "Seated Row",
      description: "N/A",
      tags: ["Back", "Machine", "Row", "Pull", "Lats", "Arms"],
    ),
    Exercise(id: "13", name: "Plank", description: "N/A", tags: ["Core", "Abs", "Bodyweight", "Static", "Stability"]),
    Exercise(
      id: "14",
      name: "Russian Twists",
      description: "N/A",
      tags: ["Core", "Obliques", "Abs", "Bodyweight", "Rotation"],
    ),
    Exercise(id: "15", name: "Leg Curls", description: "N/A", tags: ["Hamstrings", "Machine", "Pull", "Legs"]),
    Exercise(id: "16", name: "Leg Extensions", description: "N/A", tags: ["Quads", "Machine", "Legs", "Push"]),
    Exercise(
      id: "17",
      name: "Calf Raises",
      description: "N/A",
      tags: ["Calves", "Bodyweight", "Machine", "Legs", "Push"],
    ),
    Exercise(
      id: "18",
      name: "Arnold Press",
      description: "N/A",
      tags: ["Shoulders", "Dumbell", "Push", "Delts", "Arms"],
    ),
    Exercise(id: "19", name: "Chest Fly", description: "N/A", tags: ["Chest", "Dumbell", "Cable", "Push", "Pecs"]),
    Exercise(
      id: "20",
      name: "Face Pulls",
      description: "N/A",
      tags: ["Shoulders", "Rear Delts", "Cable", "Pull", "Upper Back"],
    ),
  ];
}
