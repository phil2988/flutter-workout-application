class ExerciseTag {
  static final String tableName = "ExerciseTag";
  static final String idColumn = "exercise_tag_id";
  static final String tagColumn = "tag";

  ExerciseTag({required this.tag, required this.id});

  final int id;
  final String tag;

  factory ExerciseTag.fromMap(Map<String, Object?> map) {
    return ExerciseTag(
      id: map[idColumn] as int,
      tag: map[tagColumn] as String,
    );
  }
}
