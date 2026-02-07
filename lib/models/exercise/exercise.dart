import 'package:workout_app/models/exercise/exercise_tag.dart';

class Exercise {
  static final String tableName = "Exercise";
  static final String idColumn = "exercise_id";
  static final String nameColumn = "name";
  static final String descriptionColumn = "description";
  static final String tagsColumn = ExerciseTag.idColumn;

  Exercise({
    required this.id,
    required this.name,
    required this.description,
    this.tags,
  });
  final int id;
  final String name;
  final String description;
  List<String>? tags = [];

  Map<String, Object?> toMap() {
    return {
      idColumn: id,
      nameColumn: name,
      descriptionColumn: description,
      tagsColumn: tags,
    };
  }

  factory Exercise.fromMap(Map<String, Object?> map) {
    return Exercise(
      id: map[idColumn] as int,
      name: map[nameColumn] as String,
      description: map[descriptionColumn] as String,
      tags: map[tagsColumn] == null ? [] : map[tagsColumn] as List<String>,
    );
  }
}
