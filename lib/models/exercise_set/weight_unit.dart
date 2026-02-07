enum WeightUnit{
  kgs(databaseValue: 0), lbs(databaseValue: 1), oz(databaseValue: 2), st(databaseValue: 3);
  static final String columnName = "weight_unit";
  final int databaseValue;

  const WeightUnit({required this.databaseValue});

  WeightUnit fromMap(Map<String, Object> map){
    WeightUnit returnWeightUnit = WeightUnit.kgs;
    for(WeightUnit weightUnit in WeightUnit.values){
      if(weightUnit.databaseValue == map[columnName]){
        returnWeightUnit = weightUnit;
      }
    }
    return returnWeightUnit;
  }
}