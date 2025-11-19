import 'package:flutter/material.dart';
import 'package:workout_app/painters/downwards_triangle_painter.dart';
import 'package:workout_app/painters/upwards_triangle_painter.dart' show UpwardsTrianglePainter;

class IncrementalCounter<T> extends StatefulWidget {
  const IncrementalCounter({
    super.key,
    required this.text,
    required this.onStepperChanged,
    this.incrementAmount = 1,
    this.initialValue = 0,
    this.removeDecimals = false,
    this.size = const Size(80, 200),
  });

  final String text;
  final Size size;
  final double incrementAmount;
  final bool removeDecimals;
  final Function(String) onStepperChanged;
  final double initialValue;

  @override
  State<IncrementalCounter> createState() => _IncrementalCounterState();
}

class _IncrementalCounterState<T> extends State<IncrementalCounter> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    _controller.text = ensureTextInputIsValid(widget.initialValue.toString(), 0);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.incrementAmount.runtimeType != double || widget.incrementAmount.runtimeType == int) {
      throw TypeError();
    }
    return SizedBox(
      width: widget.size.width,
      height: widget.size.height,
      child: Column(
        children: [
          Text(widget.text),
          RawMaterialButton(
            onPressed: () {
              String updatedValue = ensureTextInputIsValid(_controller.text, widget.incrementAmount);
              _controller.text = updatedValue;
              widget.onStepperChanged(updatedValue);
            },
            child: CustomPaint(
              painter: UpwardsTrianglePainter(
                strokeColor: Colors.black,
                strokeWidth: 10,
                paintingStyle: PaintingStyle.fill,
              ),
              child: SizedBox(height: 25, width: 35),
            ),
          ),
          Center(
            child: TextField(
              maxLines: 1,
              maxLength: 3,
              keyboardType: TextInputType.numberWithOptions(),
              controller: _controller,
              textAlign: TextAlign.center,
              textAlignVertical: TextAlignVertical.center,
              decoration: InputDecoration(
                counterText: "",
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.zero,
              ),
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
              onTap: () {
                _controller.selection = TextSelection(baseOffset: 0, extentOffset: _controller.text.length);
              },
            ),
          ),
          RawMaterialButton(
            onPressed: () {
              String updatedValue = ensureTextInputIsValid(_controller.text, widget.incrementAmount * -1);
              _controller.text = updatedValue;
              widget.onStepperChanged(updatedValue);
            },
            child: CustomPaint(
              painter: DownwardsTrianglePainter(
                strokeColor: Colors.black,
                strokeWidth: 10,
                paintingStyle: PaintingStyle.fill,
              ),
              child: SizedBox(height: 25, width: 35),
            ),
          ),
        ],
      ),
    );
  }

  String ensureTextInputIsValid(String input, double changeAmount) {
    String returnValue;

    if (input == "" || double.parse(input) + changeAmount < 0) {
      returnValue = "0.0";
    } else {
      returnValue = (double.parse(input) + changeAmount).toString();
    }

    if (widget.removeDecimals) {
      returnValue = returnValue.split(".").first;
    }

    return returnValue;
  }
}
