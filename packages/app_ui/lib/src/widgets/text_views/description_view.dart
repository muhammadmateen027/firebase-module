import 'package:flutter/material.dart';

///
class DescriptionView extends StatelessWidget {
  ///
  const DescriptionView({Key? key, required this.description})
      : super(key: key);

  ///
  final String description;

  @override
  Widget build(BuildContext context) {
    return Text(
      description,
      style: Theme.of(context).textTheme.bodyText1,
    );
  }
}
