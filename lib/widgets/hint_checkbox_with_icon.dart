import 'package:flutter/material.dart';

class HintCheckboxWithIcon extends StatefulWidget {
  const HintCheckboxWithIcon({
    super.key,
    required this.icon,
    required this.onCheckedChanged,
    required this.hintText,
  });

  final Icon icon;
  final Function(bool) onCheckedChanged;
  final String hintText;

  @override
  State<HintCheckboxWithIcon> createState() => _HintCheckboxWithIconState();
}

class _HintCheckboxWithIconState extends State<HintCheckboxWithIcon> {
  final GlobalKey<TooltipState> _startSetTimerTooltipKey =
      GlobalKey<TooltipState>();
  bool _startSetTimer = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        widget.icon,
        Transform.scale(
          scale: 1.6,
          child: Checkbox(
            value: _startSetTimer,
            onChanged: (value) {
              setState(() {
                _startSetTimer = value ?? false;
              });

              widget.onCheckedChanged(value ?? false);
            },
          ),
        ),
        GestureDetector(
          onTap: () {
            final tooltip = _startSetTimerTooltipKey.currentState;
            if (tooltip == null) {
              return;
            }
            tooltip.ensureTooltipVisible();
          },
          child: Tooltip(
            key: _startSetTimerTooltipKey,
            waitDuration: Duration.zero,
            showDuration: Duration(seconds: 3),
            message: widget.hintText,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(8),
            ),
            margin: EdgeInsets.all(8),
            padding: EdgeInsets.all(12),
            preferBelow: false,
            textAlign: TextAlign.center,
            child: Icon(Icons.help_outline, size: 30),
          ),
        ),
      ],
    );
  }
}
