import 'package:flutter/material.dart';
import 'package:workout_app/exercise_services.dart';
import 'package:workout_app/logging/logger.dart';
import 'package:workout_app/models/exercise/exercise.dart';
import 'package:workout_app/models/exercise_set/exercise_rep.dart';
import 'package:workout_app/models/exercise_set/exercise_set.dart';
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
  ExerciseSet? _currentExerciseSet;

  final List<DropdownMenuItem<String>> _weightTypeOptions = [
    DropdownMenuItem(value: "Kgs", child: Text("Kgs")),
    DropdownMenuItem(value: "Lbs", child: Text("Lbs")),
  ];
  String? _weightTypeSelected;
  Future<List<ExerciseRep>>? _repEntryFuture;
  int _repIndex = 0;

  @override
  void initState() {
    super.initState();

    _weightTypeSelected = _weightTypeOptions.first.value;
    _repEntryFuture = getExerciseRepEntries();

    _currentExerciseSet = ExerciseSet(exercise: widget.exercise, reps: List.empty(growable: true), orderIndex: 0);
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
                  FutureBuilder<List<ExerciseRep>>(
                    future: _repEntryFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      }

                      if (snapshot.hasData && snapshot.data != null && _repIndex < (snapshot.data?.length ?? 0)) {
                        ExerciseRep currentRepEntry = snapshot.data!.elementAt(_repIndex);
                        _repsCount = currentRepEntry.reps;
                        _weightAmount = currentRepEntry.weight;
                      }
                      // Did more exercise reps than last time
                      else {
                        _repsCount = 0;
                        _weightAmount = 0;
                      }

                      // Current set display
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
                        _currentExerciseSet?.reps.add(
                          ExerciseRep(reps: _repsCount, weight: _weightAmount, orderIndex: _repIndex),
                        );
                        _repEntryFuture = getExerciseRepEntries();
                      });
                      Logger.debug(
                        "Exercise set stats: ${_repsCount}x$_weightAmount $_weightTypeSelected with timer: $_startSetTimer and recommended weight: $_recommendWeightIncrease",
                      );
                    },
                    child: Text("Next set"),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      bool result = await submitSetData();
                      if (result) {
                        Navigator.of(context).pop();
                      } else {
                        Logger.error(
                          "Failed to submit exercise set data",
                          Exception("Failed to submit exercise set data"),
                        );
                      }
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

  Future<List<ExerciseRep>> getExerciseRepEntries() async {
    return await ExerciseServices().getNewestExerciseSetData(widget.exercise.id);
  }

  Future<bool> submitSetData() async {
    bool result = await ExerciseServices().addExerciseSetData(_currentExerciseSet!);
    return result;
  }
}
