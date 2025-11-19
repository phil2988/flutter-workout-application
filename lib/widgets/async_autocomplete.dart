import 'dart:async';
import 'package:flutter/material.dart';
import 'package:workout_app/exercise_services.dart';
import 'package:workout_app/models/exercise.dart';

const Duration debounceDuration = Duration(milliseconds: 500);

class AsyncAutocomplete extends StatefulWidget {
  const AsyncAutocomplete({super.key, required this.onExerciseSelected});

  final Function(Exercise) onExerciseSelected;

  @override
  State<AsyncAutocomplete> createState() => AsyncAutocompleteState();
}

class AsyncAutocompleteState extends State<AsyncAutocomplete> {
  // The query currently being searched for. If null, there is no pending
  // request.
  String? _currentQuery;

  late final _Debounceable<List<Exercise>?, String> _debouncedSearch;

  // Calls the "remote" API to search with the given query. Returns null when
  // the call has been made obsolete.
  Future<List<Exercise>?> _search(String query) async {
    _currentQuery = query;

    final List<Exercise> options = await search(_currentQuery!);

    // If another search happened after this one, throw away these options.
    if (_currentQuery != query) {
      return null;
    }
    _currentQuery = null;

    return options;
  }

  @override
  void initState() {
    super.initState();
    _debouncedSearch = _debounce<List<Exercise>?, String>(_search);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const SizedBox(height: 32.0),
        Autocomplete<Exercise>(
          fieldViewBuilder: (
            BuildContext context,
            TextEditingController controller,
            FocusNode focusNode,
            VoidCallback onFieldSubmitted,
          ) {
            return TextFormField(
              decoration: InputDecoration(border: OutlineInputBorder(), hintText: "eg. Benchpress"),
              controller: controller,
              focusNode: focusNode,
              onFieldSubmitted: (String value) {
                onFieldSubmitted();
              },
            );
          },
          optionsBuilder: (TextEditingValue textEditingValue) async {
            final List<Exercise>? options = await _debouncedSearch(textEditingValue.text);
            if (options == null || options.isEmpty) {
              return [];
            }

            return options;
          },
          displayStringForOption: (option) => option.name,
          onSelected: (Exercise selection) {
            widget.onExerciseSelected(selection);
          },
        ),
      ],
    );
  }

  static Future<List<Exercise>> search(String query) async {
    List<Exercise> allExercises = await ExerciseServices().getAllExercises();

    if (query == '') {
      return List<Exercise>.empty();
    }

    List<Exercise> matchingExercises = [];

    // TODO: Optimize
    for (Exercise exercise in allExercises) {
      for (String tag in exercise.tags) {
        if (tag.toLowerCase().contains(query.toLowerCase())) {
          // Only add if not already added
          if (!matchingExercises.contains(exercise)) {
            matchingExercises.add(exercise);
          }
        }
      }
    }

    matchingExercises.sort((e1, e2) => e1.name.compareTo(e2.name));

    return matchingExercises;
  }
}

typedef _Debounceable<S, T> = Future<S?> Function(T parameter);

/// Returns a new function that is a debounced version of the given function.
///
/// This means that the original function will be called only after no calls
/// have been made for the given Duration.
_Debounceable<S, T> _debounce<S, T>(_Debounceable<S?, T> function) {
  _DebounceTimer? debounceTimer;

  return (T parameter) async {
    if (debounceTimer != null && !debounceTimer!.isCompleted) {
      debounceTimer!.cancel();
    }
    debounceTimer = _DebounceTimer();
    try {
      await debounceTimer!.future;
    } on _CancelException {
      return null;
    }
    return function(parameter);
  };
}

// A wrapper around Timer used for debouncing.
class _DebounceTimer {
  _DebounceTimer() {
    _timer = Timer(debounceDuration, _onComplete);
  }

  late final Timer _timer;
  final Completer<void> _completer = Completer<void>();

  void _onComplete() {
    _completer.complete();
  }

  Future<void> get future => _completer.future;

  bool get isCompleted => _completer.isCompleted;

  void cancel() {
    _timer.cancel();
    _completer.completeError(const _CancelException());
  }
}

// An exception indicating that the timer was canceled.
class _CancelException implements Exception {
  const _CancelException();
}
