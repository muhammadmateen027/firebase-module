import 'package:app_ui/app_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// Orange-bordered textfield for searches.
class SearchField extends StatelessWidget {
  /// Builds an orange-bordered text field.
  const SearchField({
    Key? key,
    this.controller,
    required this.label,
    required this.onChanged,
  }) : super(key: key);

  /// Placeholder for the textfield
  final String label;

  /// Method to execute when the textfield value is changed
  final void Function(String) onChanged;

  /// A controller for the textfield
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return CupertinoTextField(
      controller: controller,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.search,
      placeholder: label,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
      textAlignVertical: TextAlignVertical.center,
      placeholderStyle: Theme.of(context).textTheme.bodyText2!.copyWith(
            height: 1.2,
            fontWeight: FontWeight.normal,
            fontSize: 17,
            color: CustomColors.mediumGrey,
          ),
      prefix: Padding(
        padding: const EdgeInsets.only(left: 12),
        child: Icon(
          Icons.search,
          size: 30,
          color: Theme.of(context).primaryColor,
        ),
      ),
      onChanged: onChanged,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: Theme.of(context).primaryColorLight,
          width: 2,
        ),
        color: Colors.white,
      ),
      cursorColor: Theme.of(context).primaryColor,
    );
  }
}
