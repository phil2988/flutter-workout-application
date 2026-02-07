import 'package:workout_app/models/exercise_set/weight_unit.dart';

class ExerciseRep {
  static final String tableName = "ExerciseRep";
  static final String idColumn = "exercise_rep_id";
  static final String repsColumn = "reps";
  static final String weightColumn = "weight";
  static final String weightUnitColumn = WeightUnit.columnName;
  static final String isWarmUpColumn = "is_warm_up";
  static final String orderIndexColumn = "order_index";

  ExerciseRep({
    this.id,
    required this.reps,
    required this.weight,
    this.weightUnit = WeightUnit.kgs,
    this.isWarmUp = false,
    required this.orderIndex,
  });
  final int? id;
  final int reps;
  final double weight;
  final WeightUnit weightUnit;
  final bool isWarmUp;
  final int orderIndex;

  factory ExerciseRep.fromMap(Map<String, Object?> map) {
    return ExerciseRep(
      id: map[idColumn] as int,
      reps: map[repsColumn] as int,
      weight: map[weightColumn] as double,
      weightUnit: map[weightUnitColumn] as WeightUnit,
      isWarmUp: (map[isWarmUpColumn] ?? false) as bool,
      orderIndex: map[orderIndexColumn] as int,
    );
  }

  Map<String, Object?> toMap() {
    return {
      idColumn: id,
      repsColumn: reps,
      weightColumn: weight,
      weightUnitColumn: weightUnit,
      isWarmUpColumn: isWarmUp,
      orderIndexColumn: orderIndex,
    };
  }
}
