import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';

/// Primary button widget
class PrimaryButton extends StatelessWidget {
  /// Primary button widget
  const PrimaryButton({
    Key? key,
    required this.onPressed,
    required this.label,
    this.isLoading = false,
    this.buttonStyle,
    this.labelStyle,
  }) : super(key: key);

  /// Function that handles the event when the button is pressed
  final void Function()? onPressed;

  /// The button's label. Friendly reminder to use localizations!
  final String label;

  /// If set to true, the button will show Peachee animated loading logo.
  final bool isLoading;

  /// If not null, this style is used
  final ButtonStyle? buttonStyle;

  /// If not null, this text style is used for the label
  final TextStyle? labelStyle;

  @override
  Widget build(BuildContext context) {
    const verticalOffset = 3.0;

    return ElevatedButton(
      onPressed: isLoading ? null : onPressed,
      style: buttonStyle ??
          ButtonStyle(
            splashFactory: NoSplash.splashFactory,
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            minimumSize: MaterialStateProperty.resolveWith(
              (_) => const Size(double.infinity, 56),
            ),
            padding: MaterialStateProperty.resolveWith(
              (_) => const EdgeInsets.only(
                  top: AppSpacing.md - verticalOffset,
                  bottom: AppSpacing.md + verticalOffset),
            ),
          ),
      child: ButtonLabel(
        label: label,
        isLoading: isLoading,
        textStyle: labelStyle,
      ),
    );
  }
}
