import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';

///
class TitleView extends StatelessWidget {
  ///
  const TitleView({Key? key, required this.label}) : super(key: key);

  ///
  final String label;

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: Theme.of(context).textTheme.headline6!.copyWith(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: CustomColors.mediumGrey),
    );
  }
}
