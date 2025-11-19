class RepEntry {
  RepEntry({required this.reps, required this.weight, this.isWarmup = false});
  final bool isWarmup;
  final int reps;
  final double weight;
}
