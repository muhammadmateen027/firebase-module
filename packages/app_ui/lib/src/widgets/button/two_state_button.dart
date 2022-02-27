import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';

/// A two state button with two callbacks. Usually used
/// with a context.select variable for active parameter
class TwoStateButton extends StatelessWidget {
  /// A two state button with two callbacks. Usually used
  /// with a context.select variable for active parameter
  const TwoStateButton(
      {Key? key,
      this.size,
      this.height,
      this.width,
      required this.onActivation,
      required this.onDeactivation,
      required this.active,
      required this.activeLabel,
      this.activeTextStyle,
      required this.inactiveLabel,
      this.inactiveTextStyle,
      this.ignorePointer = false})
      : super(key: key);

  /// Call back for tap while inactive
  final void Function() onActivation;

  /// Callback for tap while active
  final void Function() onDeactivation;

  /// Wether it is in its active or inactive state
  final bool active;

  /// The button label for th active state
  final String activeLabel;

  /// If provided uses this style instead of default style
  final TextStyle? activeTextStyle;

  /// The button label for the inactive state
  final String inactiveLabel;

  /// If provided uses this style instead of default style
  final TextStyle? inactiveTextStyle;

  /// Size of the button. [width] and [height] take precedence over [size]
  final Size? size;

  /// Width of the button. [width] takes precedence over [size]
  final double? width;

  /// Height of the button. [height] takes precedence over [size]
  final double? height;

  /// If true, the button ignores input
  final bool ignorePointer;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: ignorePointer,
      child: SizedBox(
        width: width ?? size?.width,
        height: height ?? size?.height,
        child: ElevatedButton(
          onPressed: active ? onDeactivation : onActivation,
          style: active
              ? ButtonStyle(
                  splashFactory: NoSplash.splashFactory,
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular((height ?? size?.height ?? 16) * 0.25),
                      ),
                    ),
                  ),
                  padding: MaterialStateProperty.resolveWith(
                      (states) => EdgeInsets.zero),
                  fixedSize: MaterialStateProperty.resolveWith(
                      (states) => const Size(50, 20)),
                )
              : ButtonStyle(
                  side:
                      MaterialStateProperty.resolveWith((_) => const BorderSide(
                            color: CustomColors.primaryColor,
                          )),
                  backgroundColor: MaterialStateProperty.resolveWith(
                      (_) => CustomColors.white),
                  splashFactory: NoSplash.splashFactory,
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(8),
                      ),
                    ),
                  ),
                  padding: MaterialStateProperty.resolveWith(
                      (states) => EdgeInsets.zero),
                  fixedSize: MaterialStateProperty.resolveWith(
                      (states) => const Size(50, 20)),
                ),
          child: active
              ? Text(
                  activeLabel,
                  style: activeTextStyle ??
                      Theme.of(context).textTheme.button!.copyWith(
                            fontSize: 11,
                            color: CustomColors.white,
                          ),
                )
              : Text(
                  inactiveLabel,
                  style: inactiveTextStyle ??
                      Theme.of(context).textTheme.button!.copyWith(
                            fontSize: 11,
                            color: CustomColors.primaryColor,
                          ),
                ),
        ),
      ),
    );
  }
}
