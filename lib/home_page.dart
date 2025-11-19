import 'package:flutter/material.dart';
import 'package:workout_app/select_exercise_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Spacer(flex: 2),
              Text("Home page"),
              Spacer(flex: 1),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => SelectExercisePage()));
                },
                style: ElevatedButton.styleFrom(textStyle: TextStyle(fontSize: 26)),
                child: Text("Start on-the-fly workout"),
              ),
              Spacer(flex: 4),
            ],
          ),
        ),
      ),
    );
  }
}
