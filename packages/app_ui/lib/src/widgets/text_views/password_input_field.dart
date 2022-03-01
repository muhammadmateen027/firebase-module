import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';

/// {@template password_input_field}
/// Creates a [TextField] with [prefixIcon] and [hintText],
///  specially used for passwords
///
class PasswordInputField extends StatelessWidget {
  /// {@macro password_input_field}
  const PasswordInputField({
    required this.onChanged,
    this.errorText,
    this.hintText,
    this.prefixIcon,
    this.controller,
    this.onSubmitted,
    this.obscureText = true,
    this.showVisibilityIcon = true,
    Key? key,
  }) : super(key: key);

  /// onChanged Method to be call after changes in [Input Field]
  final ValueChanged<String>? onChanged;

  ///error message after validation error in [Input Field]
  final String? errorText;

  ///Whether to hide the password being edited.
  ///When this is set to false, all the characters in the text field
  ///are replaced by obscuringCharacter.
  ///Defaults to false. Cannot be null.
  final bool obscureText;

  /// this will be used to either show the suffix or not
  final bool showVisibilityIcon;

  /// hintText used to identify [Input Field]
  final String? hintText;

  ///prefix Icon used on [InputDecoration]
  final Widget? prefixIcon;

  /// Callback function called when submit
  final ValueChanged<String>? onSubmitted;

  /// Controls the text being edited. If null,
  ///  this widget will create its own [TextEditingController].
  final TextEditingController? controller;


  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return TextField(
      controller: controller,
      obscureText: obscureText,
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      keyboardType: TextInputType.text,
      obscuringCharacter: '●',
      style: TextStyle(letterSpacing: obscureText ? 2 : 0),
      decoration: InputDecoration(
        prefixIconConstraints: const BoxConstraints(
          maxHeight: 50,
          maxWidth: 50,
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: theme.primaryColor),
        ),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: CustomColors.grey3),
        ),
        hintStyle: AppTextStyle.bodyText1.copyWith(
          color: CustomColors.grey3,
          fontSize: 16,
          letterSpacing: 0,
        ),
        prefixIcon: Padding(
          padding: const EdgeInsets.only(right: 11),
          child: prefixIcon,
        ),
        hintText: hintText,
        errorText: errorText,
        errorStyle: theme.textTheme.caption!.copyWith(
          color: theme.errorColor,
        ),
        errorMaxLines: 3,
      ),
      autocorrect: false,
    );
  }
}
