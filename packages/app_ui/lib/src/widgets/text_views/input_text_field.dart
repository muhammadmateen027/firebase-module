import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// {@template input_field}

/// Creates a [TextField]. The [onChanged] parameter is required.
class InputTextField extends StatelessWidget {
  /// {@macro password_input_field}
  const InputTextField({
    required this.onChanged,
    this.errorText,
    this.hintText,
    this.onSubmitted,
    this.prefixIcon,
    this.autoCorrect = false,
    this.isErrorMessage = true,
    this.keyboardType,
    this.controller,
    this.maxLength,
    this.enabledBorderColor = CustomColors.grey3,
    this.hintMaxLines,
    Key? key,
    this.underlineInputBorder = true,
  }) : super(key: key);

  ///onChanged method to be call after changes in [InputTextField]
  final ValueChanged<String>? onChanged;

  ///error message after validation error in [InputTextField]
  final String? errorText;

  /// hintText used to identify [InputTextField]
  final String? hintText;

  ///prefix Icon used on [InputDecoration]
  final Widget? prefixIcon;

  /// KeyboardType used for this [TextField],
  /// by default is [TextInputType.emailAddress]
  final TextInputType? keyboardType;

  /// Callback function called when submit
  final ValueChanged<String>? onSubmitted;

  /// Callback function called when submit
  // final ValueChanged<String>? validator;

  /// Whether to enable auto correction. Defaults to true. Cannot be null.
  final bool autoCorrect;

  ///  The [maxLength] number of characters (Unicode scalar values) to allow
  // in the text field.
  final int? maxLength;

  /// Controls the text being edited. If null,
  ///  this widget will create its own [TextEditingController].
  final TextEditingController? controller;

  /// This variable will be used to change the error color on basis
  /// of either it is error or success message
  final bool isErrorMessage;

  /// A  border color that indicates if field is enabled to edit
  final Color enabledBorderColor;

  /// If not provided it is 3
  final int? hintMaxLines;

  /// Whether or not the text field has a bottom border decoration
  final bool underlineInputBorder;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return TextField(
      smartDashesType: SmartDashesType.disabled,
      maxLengthEnforcement: MaxLengthEnforcement.enforced,
      inputFormatters: [
        LengthLimitingTextInputFormatter(maxLength),
      ],
      onChanged: onChanged,
      keyboardType: keyboardType ?? TextInputType.text,
      decoration: InputDecoration(
        hintStyle: AppTextStyle.bodyText1.copyWith(
          color: CustomColors.grey3,
          fontSize: 16,
        ),
        prefixIconConstraints: const BoxConstraints(
          maxHeight: 50,
          maxWidth: 50,
        ),
        border: underlineInputBorder
            ? const UnderlineInputBorder(
                borderSide: BorderSide(color: CustomColors.grey3),
              )
            : InputBorder.none,
        enabledBorder: underlineInputBorder
            ? UnderlineInputBorder(
                borderSide: BorderSide(color: enabledBorderColor),
              )
            : InputBorder.none,
        disabledBorder: underlineInputBorder
            ? const UnderlineInputBorder(
                borderSide: BorderSide(color: CustomColors.grey3),
              )
            : InputBorder.none,
        focusedBorder: underlineInputBorder
            ? UnderlineInputBorder(
                borderSide: BorderSide(color: theme.primaryColor),
              )
            : InputBorder.none,
        prefixIcon: prefixIcon != null
            ? Padding(
                padding: const EdgeInsets.only(right: 11),
                child: prefixIcon,
              )
            : null,
        hintText: hintText,
        errorText: errorText,
        errorStyle: theme.textTheme.caption!.copyWith(
          color: isErrorMessage ? theme.errorColor : theme.primaryColor,
        ),
        errorMaxLines: 3,
        hintMaxLines: hintMaxLines ?? 3,
      ),
      onSubmitted: onSubmitted,
      autocorrect: autoCorrect,
      controller: controller,
    );
  }
}
