import 'package:flutter/material.dart';
import 'package:workout_app/models/exercise.dart';
import 'package:workout_app/models/rep_entry.dart';
import 'package:workout_app/widgets/hint_checkbox_with_icon.dart';
import 'package:workout_app/widgets/incremental_counter.dart';

class OnTheFlyWorkoutPage extends StatefulWidget {
  const OnTheFlyWorkoutPage({super.key, required this.exercise});

  final Exercise exercise;

  @override
  State<OnTheFlyWorkoutPage> createState() => _OnTheFlyWorkoutPageState();
}

class _OnTheFlyWorkoutPageState extends State<OnTheFlyWorkoutPage> {
  bool _recommendWeightIncrease = false;
  bool _startSetTimer = false;
  int _repsCount = 0;
  double _weightAmount = 0;
  final List<DropdownMenuItem<String>> _weightTypeOptions = [
    DropdownMenuItem(value: "Kgs", child: Text("Kgs")),
    DropdownMenuItem(value: "Lbs", child: Text("Lbs")),
  ];
  String? _weightTypeSelected;
  Future<List<RepEntry>>? _repEntryFuture;
  int _repIndex = 0;

  @override
  void initState() {
    super.initState();

    _weightTypeSelected = _weightTypeOptions.first.value;
    _repEntryFuture = getExerciseRepEntries();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: LayoutBuilder(
          builder: (context, constraints) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Spacer(flex: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: 10,
                    children: [
                      HintCheckboxWithIcon(
                        icon: Icon(Icons.timer_outlined),
                        onCheckedChanged:
                            (checked) => {
                              setState(() {
                                _startSetTimer = checked;
                              }),
                            },
                        hintText:
                            "Automatically start a timer for when you need to start your next set. The timer will start when pressing the finish set button below. The timer length can be configured in your profile settings",
                      ),
                      HintCheckboxWithIcon(
                        icon: Icon(Icons.fitness_center),
                        onCheckedChanged:
                            (checked) => {
                              setState(() {
                                _recommendWeightIncrease = checked;
                              }),
                            },
                        hintText:
                            "Let the app recommend when you should increase weight for your exercise. The weight will be colored green when a recommended increase is found.",
                      ),
                      SizedBox(
                        width: constraints.maxWidth * 0.2,
                        child: DropdownButton<String>(
                          value: _weightTypeSelected,
                          items: _weightTypeOptions,
                          onChanged: (value) {
                            setState(() {
                              _weightTypeSelected = value;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  Spacer(flex: 1),
                  FutureBuilder<List<RepEntry>>(
                    future: _repEntryFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      }

                      if (snapshot.hasData && snapshot.data != null && _repIndex < (snapshot.data?.length ?? 0)) {
                        RepEntry currentRepEntry = snapshot.data!.elementAt(_repIndex);

                        print("Got ${currentRepEntry.reps}x${currentRepEntry.weight}");
                        _repsCount = currentRepEntry.reps;
                        _weightAmount = currentRepEntry.weight;
                      }
                      // Did more exercise reps than last time
                      else {
                        _repsCount = 0;
                        _weightAmount = 0;
                      }

                      return Row(
                        spacing: 5,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IncrementalCounter(
                            text: "Reps",
                            initialValue: _repsCount.toDouble(),
                            removeDecimals: true,
                            onStepperChanged: (reps) {
                              _repsCount = int.tryParse(reps.toString()) ?? 0;
                            },
                          ),
                          IncrementalCounter(
                            text: "Weight",
                            initialValue: _weightAmount,
                            onStepperChanged: (weight) {
                              _weightAmount = double.tryParse(weight.toString()) ?? 0;
                            },
                          ),
                        ],
                      );
                    },
                  ),
                  Spacer(flex: 1),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _repIndex++;
                        _repEntryFuture = getExerciseRepEntries();
                      });
                      print(
                        "Exercise set stats: ${_repsCount}x$_weightAmount $_weightTypeSelected with timer: $_startSetTimer and recommended weight: $_recommendWeightIncrease",
                      );
                    },
                    child: Text("Next set"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text("Finish exercise"),
                  ),
                  Spacer(flex: 6),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Future<List<RepEntry>> getExerciseRepEntries() async {
    await Future.delayed(Duration(seconds: 1));
    return Future.value([
      RepEntry(reps: 10, weight: 22.5),
      RepEntry(reps: 8, weight: 22.5),
      RepEntry(reps: 7, weight: 22.5),
    ]);
  }

  Future<bool> submitSetData() {
    // ExerciseServices().submitExerciseData();
    return Future.value(false);
  }
}
