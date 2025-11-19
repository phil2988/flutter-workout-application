import 'package:flutter/material.dart';
import 'package:workout_app/on_the_fly_workout_page.dart';
import 'package:workout_app/widgets/async_autocomplete.dart';

class SelectExercisePage extends StatefulWidget {
  const SelectExercisePage({super.key});

  @override
  State<SelectExercisePage> createState() => _SelectExercisePageState();
}

class _SelectExercisePageState extends State<SelectExercisePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Scaffold(
            body: Center(
              child: Column(
                children: [
                  Spacer(flex: 1),
                  Text("Select your exercise", style: TextStyle(fontSize: 26)),
                  SizedBox(
                    width: constraints.maxWidth * 0.8,
                    child: AsyncAutocomplete(
                      onExerciseSelected: (selectedExercise) {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => OnTheFlyWorkoutPage(exercise: selectedExercise)),
                        );
                      },
                    ),
                  ),
                  Spacer(flex: 5),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
