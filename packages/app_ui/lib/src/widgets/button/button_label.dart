import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';

/// Button label widget
class ButtonLabel extends StatelessWidget {
  /// Primary button label. if isLoading is set to true, the widget will
  /// display the Peachee animated loading logo
  const ButtonLabel({
    Key? key,
    this.isLoading = false,
    required this.label,
    this.textStyle,
  }) : super(key: key);

  /// If set to true, this will display the Peachee animated loading logo
  /// instead of the label
  final bool isLoading;

  /// The label the widget will display. Friendly reminder to use localizations!
  final String label;

  /// Use to add styling to text.
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: textStyle ??
          Theme.of(context).textTheme.button!.copyWith(
                color: CustomColors.white,
                fontWeight: FontWeight.bold,
              ),
    );
  }
}
