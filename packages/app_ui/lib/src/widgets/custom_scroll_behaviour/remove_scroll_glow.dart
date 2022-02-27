import 'package:flutter/material.dart';

/// To remove scroll glow of the list view
class RemoveScrollGlow extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
    BuildContext context,
    Widget child,
    AxisDirection axisDirection,
  ) {
    return child;
  }
}
