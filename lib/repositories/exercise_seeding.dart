import 'package:workout_app/models/exercise/exercise.dart';
import 'package:workout_app/models/exercise/exercise_exercise_tag_junction.dart';
import 'package:workout_app/models/exercise/exercise_tag.dart';

class ExerciseSeeding {
  static final List<Exercise> exercises = [
    Exercise(id: 0, name: "Deadlift", description: "N/A"),
    Exercise(id: 1, name: "Overhead Press", description: "N/A"),
    Exercise(id: 2, name: "Pull-Ups", description: "N/A"),
    Exercise(id: 3, name: "Lat Pulldown", description: "N/A"),
    Exercise(id: 4, name: "Leg Press", description: "N/A"),
    Exercise(id: 5, name: "Lunges", description: "N/A"),
    Exercise(id: 6, name: "Incline Dumbbell Press", description: "N/A"),
    Exercise(id: 7, name: "Seated Row", description: "N/A"),
    Exercise(id: 8, name: "Plank", description: "N/A"),
    Exercise(id: 9, name: "Russian Twists", description: "N/A"),
    Exercise(id: 10, name: "Leg Curls", description: "N/A"),
    Exercise(id: 11, name: "Leg Extensions", description: "N/A"),
    Exercise(id: 12, name: "Calf Raises", description: "N/A"),
    Exercise(id: 13, name: "Arnold Press", description: "N/A"),
    Exercise(id: 14, name: "Chest Fly", description: "N/A"),
    Exercise(id: 15, name: "Face Pulls", description: "N/A"),
  ];

  static final List<ExerciseTag> exerciseTags = [
    ExerciseTag(id: 0, tag: "Back"),
    ExerciseTag(id: 1, tag: "Hamstrings"),
    ExerciseTag(id: 2, tag: "Barbell"),
    ExerciseTag(id: 3, tag: "Pull"),
    ExerciseTag(id: 4, tag: "Legs"),
    ExerciseTag(id: 5, tag: "Core"),
    ExerciseTag(id: 6, tag: "Shoulders"),
    ExerciseTag(id: 7, tag: "Press"),
    ExerciseTag(id: 8, tag: "Push"),
    ExerciseTag(id: 9, tag: "Delts"),
    ExerciseTag(id: 10, tag: "Arms"),
    ExerciseTag(id: 11, tag: "Lats"),
    ExerciseTag(id: 12, tag: "Bodyweight"),
    ExerciseTag(id: 13, tag: "Cable"),
    ExerciseTag(id: 14, tag: "Quads"),
    ExerciseTag(id: 15, tag: "Glutes"),
    ExerciseTag(id: 16, tag: "Machine"),
    ExerciseTag(id: 17, tag: "Balance"),
    ExerciseTag(id: 18, tag: "Dumbell"),
    ExerciseTag(id: 19, tag: "Chest"),
    ExerciseTag(id: 20, tag: "Incline"),
    ExerciseTag(id: 21, tag: "Upper Chest"),
    ExerciseTag(id: 22, tag: "Row"),
    ExerciseTag(id: 23, tag: "Abs"),
    ExerciseTag(id: 24, tag: "Static"),
    ExerciseTag(id: 25, tag: "Stability"),
    ExerciseTag(id: 26, tag: "Obliques"),
    ExerciseTag(id: 27, tag: "Rotation"),
    ExerciseTag(id: 28, tag: "Calves"),
    ExerciseTag(id: 29, tag: "Pecs"),
    ExerciseTag(id: 30, tag: "Rear Delts"),
    ExerciseTag(id: 31, tag: "Upper Back"),
  ];

  static final List<ExerciseExerciseTagJunction> exerciseExerciseTagJunctions = [
    // Deadlift (0)
    ExerciseExerciseTagJunction(exerciseId: 0, exerciseTagId: 0),
    ExerciseExerciseTagJunction(exerciseId: 0, exerciseTagId: 1),
    ExerciseExerciseTagJunction(exerciseId: 0, exerciseTagId: 2),
    ExerciseExerciseTagJunction(exerciseId: 0, exerciseTagId: 3),
    ExerciseExerciseTagJunction(exerciseId: 0, exerciseTagId: 4),
    ExerciseExerciseTagJunction(exerciseId: 0, exerciseTagId: 5),

    // Overhead Press (1)
    ExerciseExerciseTagJunction(exerciseId: 1, exerciseTagId: 6),
    ExerciseExerciseTagJunction(exerciseId: 1, exerciseTagId: 2),
    ExerciseExerciseTagJunction(exerciseId: 1, exerciseTagId: 7),
    ExerciseExerciseTagJunction(exerciseId: 1, exerciseTagId: 8),
    ExerciseExerciseTagJunction(exerciseId: 1, exerciseTagId: 9),
    ExerciseExerciseTagJunction(exerciseId: 1, exerciseTagId: 10),

    // Pull-Ups (2)
    ExerciseExerciseTagJunction(exerciseId: 2, exerciseTagId: 0),
    ExerciseExerciseTagJunction(exerciseId: 2, exerciseTagId: 11),
    ExerciseExerciseTagJunction(exerciseId: 2, exerciseTagId: 12),
    ExerciseExerciseTagJunction(exerciseId: 2, exerciseTagId: 3),
    ExerciseExerciseTagJunction(exerciseId: 2, exerciseTagId: 10),
    ExerciseExerciseTagJunction(exerciseId: 2, exerciseTagId: 5),

    // Lat Pulldown (3)
    ExerciseExerciseTagJunction(exerciseId: 3, exerciseTagId: 0),
    ExerciseExerciseTagJunction(exerciseId: 3, exerciseTagId: 11),
    ExerciseExerciseTagJunction(exerciseId: 3, exerciseTagId: 13),
    ExerciseExerciseTagJunction(exerciseId: 3, exerciseTagId: 3),
    ExerciseExerciseTagJunction(exerciseId: 3, exerciseTagId: 10),

    // Leg Press (4)
    ExerciseExerciseTagJunction(exerciseId: 4, exerciseTagId: 4),
    ExerciseExerciseTagJunction(exerciseId: 4, exerciseTagId: 14),
    ExerciseExerciseTagJunction(exerciseId: 4, exerciseTagId: 15),
    ExerciseExerciseTagJunction(exerciseId: 4, exerciseTagId: 8),
    ExerciseExerciseTagJunction(exerciseId: 4, exerciseTagId: 16),

    // Lunges (5)
    ExerciseExerciseTagJunction(exerciseId: 5, exerciseTagId: 4),
    ExerciseExerciseTagJunction(exerciseId: 5, exerciseTagId: 15),
    ExerciseExerciseTagJunction(exerciseId: 5, exerciseTagId: 12),
    ExerciseExerciseTagJunction(exerciseId: 5, exerciseTagId: 18),
    ExerciseExerciseTagJunction(exerciseId: 5, exerciseTagId: 17),
    ExerciseExerciseTagJunction(exerciseId: 5, exerciseTagId: 8),

    // Incline Dumbbell Press (6)
    ExerciseExerciseTagJunction(exerciseId: 6, exerciseTagId: 19),
    ExerciseExerciseTagJunction(exerciseId: 6, exerciseTagId: 20),
    ExerciseExerciseTagJunction(exerciseId: 6, exerciseTagId: 18),
    ExerciseExerciseTagJunction(exerciseId: 6, exerciseTagId: 8),
    ExerciseExerciseTagJunction(exerciseId: 6, exerciseTagId: 21),

    // Seated Row (7)
    ExerciseExerciseTagJunction(exerciseId: 7, exerciseTagId: 0),
    ExerciseExerciseTagJunction(exerciseId: 7, exerciseTagId: 16),
    ExerciseExerciseTagJunction(exerciseId: 7, exerciseTagId: 22),
    ExerciseExerciseTagJunction(exerciseId: 7, exerciseTagId: 3),
    ExerciseExerciseTagJunction(exerciseId: 7, exerciseTagId: 11),
    ExerciseExerciseTagJunction(exerciseId: 7, exerciseTagId: 10),

    // Plank (8)
    ExerciseExerciseTagJunction(exerciseId: 8, exerciseTagId: 5),
    ExerciseExerciseTagJunction(exerciseId: 8, exerciseTagId: 23),
    ExerciseExerciseTagJunction(exerciseId: 8, exerciseTagId: 12),
    ExerciseExerciseTagJunction(exerciseId: 8, exerciseTagId: 24),
    ExerciseExerciseTagJunction(exerciseId: 8, exerciseTagId: 25),

    // Russian Twists (9)
    ExerciseExerciseTagJunction(exerciseId: 9, exerciseTagId: 5),
    ExerciseExerciseTagJunction(exerciseId: 9, exerciseTagId: 26),
    ExerciseExerciseTagJunction(exerciseId: 9, exerciseTagId: 23),
    ExerciseExerciseTagJunction(exerciseId: 9, exerciseTagId: 12),
    ExerciseExerciseTagJunction(exerciseId: 9, exerciseTagId: 27),

    // Leg Curls (10)
    ExerciseExerciseTagJunction(exerciseId: 10, exerciseTagId: 1),
    ExerciseExerciseTagJunction(exerciseId: 10, exerciseTagId: 16),
    ExerciseExerciseTagJunction(exerciseId: 10, exerciseTagId: 3),
    ExerciseExerciseTagJunction(exerciseId: 10, exerciseTagId: 4),

    // Leg Extensions (11)
    ExerciseExerciseTagJunction(exerciseId: 11, exerciseTagId: 14),
    ExerciseExerciseTagJunction(exerciseId: 11, exerciseTagId: 16),
    ExerciseExerciseTagJunction(exerciseId: 11, exerciseTagId: 4),
    ExerciseExerciseTagJunction(exerciseId: 11, exerciseTagId: 8),

    // Calf Raises (12)
    ExerciseExerciseTagJunction(exerciseId: 12, exerciseTagId: 28),
    ExerciseExerciseTagJunction(exerciseId: 12, exerciseTagId: 12),
    ExerciseExerciseTagJunction(exerciseId: 12, exerciseTagId: 16),
    ExerciseExerciseTagJunction(exerciseId: 12, exerciseTagId: 4),
    ExerciseExerciseTagJunction(exerciseId: 12, exerciseTagId: 8),

    // Arnold Press (13)
    ExerciseExerciseTagJunction(exerciseId: 13, exerciseTagId: 6),
    ExerciseExerciseTagJunction(exerciseId: 13, exerciseTagId: 18),
    ExerciseExerciseTagJunction(exerciseId: 13, exerciseTagId: 8),
    ExerciseExerciseTagJunction(exerciseId: 13, exerciseTagId: 9),
    ExerciseExerciseTagJunction(exerciseId: 13, exerciseTagId: 10),

    // Chest Fly (14)
    ExerciseExerciseTagJunction(exerciseId: 14, exerciseTagId: 19),
    ExerciseExerciseTagJunction(exerciseId: 14, exerciseTagId: 18),
    ExerciseExerciseTagJunction(exerciseId: 14, exerciseTagId: 13),
    ExerciseExerciseTagJunction(exerciseId: 14, exerciseTagId: 8),
    ExerciseExerciseTagJunction(exerciseId: 14, exerciseTagId: 29),

    // Face Pulls (15)
    ExerciseExerciseTagJunction(exerciseId: 15, exerciseTagId: 6),
    ExerciseExerciseTagJunction(exerciseId: 15, exerciseTagId: 30),
    ExerciseExerciseTagJunction(exerciseId: 15, exerciseTagId: 13),
    ExerciseExerciseTagJunction(exerciseId: 15, exerciseTagId: 3),
    ExerciseExerciseTagJunction(exerciseId: 15, exerciseTagId: 31),
  ];

  static final List<Exercise> completeExercises = [
    Exercise(
      id: 0,
      name: "Deadlift",
      description: "N/A",
      tags: [
        "Back",
        "Hamstrings",
        "Barbell",
        "Pull",
        "Legs",
        "Core",
      ],
    ),
    Exercise(
      id: 1,
      name: "Overhead Press",
      description: "N/A",
      tags: [
        "Shoulders",
        "Barbell",
        "Press",
        "Push",
        "Delts",
        "Arms",
      ],
    ),
    Exercise(
      id: 2,
      name: "Pull-Ups",
      description: "N/A",
      tags: [
        "Back",
        "Lats",
        "Bodyweight",
        "Pull",
        "Arms",
        "Core",
      ],
    ),
    Exercise(
      id: 3,
      name: "Lat Pulldown",
      description: "N/A",
      tags: [
        "Back",
        "Lats",
        "Cable",
        "Pull",
        "Arms",
      ],
    ),
    Exercise(
      id: 4,
      name: "Leg Press",
      description: "N/A",
      tags: [
        "Legs",
        "Quads",
        "Glutes",
        "Push",
        "Machine",
      ],
    ),
    Exercise(
      id: 5,
      name: "Lunges",
      description: "N/A",
      tags: [
        "Legs",
        "Glutes",
        "Bodyweight",
        "Dumbbell",
        "Balance",
        "Push",
      ],
    ),
    Exercise(
      id: 6,
      name: "Incline Dumbbell Press",
      description: "N/A",
      tags: [
        "Chest",
        "Incline",
        "Dumbbell",
        "Push",
        "Upper Chest",
      ],
    ),
    Exercise(
      id: 7,
      name: "Seated Row",
      description: "N/A",
      tags: [
        "Back",
        "Machine",
        "Row",
        "Pull",
        "Lats",
        "Arms",
      ],
    ),
    Exercise(
      id: 8,
      name: "Plank",
      description: "N/A",
      tags: [
        "Core",
        "Abs",
        "Bodyweight",
        "Static",
        "Stability",
      ],
    ),
    Exercise(
      id: 9,
      name: "Russian Twists",
      description: "N/A",
      tags: [
        "Core",
        "Obliques",
        "Abs",
        "Bodyweight",
        "Rotation",
      ],
    ),
    Exercise(
      id: 10,
      name: "Leg Curls",
      description: "N/A",
      tags: [
        "Hamstrings",
        "Machine",
        "Pull",
        "Legs",
      ],
    ),
    Exercise(
      id: 11,
      name: "Leg Extensions",
      description: "N/A",
      tags: [
        "Quads",
        "Machine",
        "Legs",
        "Push",
      ],
    ),
    Exercise(
      id: 12,
      name: "Calf Raises",
      description: "N/A",
      tags: [
        "Calves",
        "Bodyweight",
        "Machine",
        "Legs",
        "Push",
      ],
    ),
    Exercise(
      id: 13,
      name: "Arnold Press",
      description: "N/A",
      tags: [
        "Shoulders",
        "Dumbbell",
        "Push",
        "Delts",
        "Arms",
      ],
    ),
    Exercise(
      id: 14,
      name: "Chest Fly",
      description: "N/A",
      tags: [
        "Chest",
        "Dumbbell",
        "Cable",
        "Push",
        "Pecs",
      ],
    ),
    Exercise(
      id: 15,
      name: "Face Pulls",
      description: "N/A",
      tags: [
        "Shoulders",
        "Rear Delts",
        "Cable",
        "Pull",
        "Upper Back",
      ],
    ),
  ];
}
