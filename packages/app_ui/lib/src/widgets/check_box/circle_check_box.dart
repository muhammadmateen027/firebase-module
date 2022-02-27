import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';

///
class CircleCheckBox extends StatelessWidget {
  ///
  const CircleCheckBox({
    Key? key,
    this.isValid = false,
    this.isInvalidCase = false,
    this.label = '',
  }) : super(key: key);

  ///
  final String label;

  ///
  final bool isValid;

  ///
  final bool isInvalidCase;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(
          child: Icon(
            isValid ? Icons.check_circle_rounded : Icons.radio_button_unchecked,
            color: isValid ? theme.primaryColor : CustomColors.grey4,
            size: 20,
          ),
        ),
        const SizedBox(
          width: AppSpacing.sm,
        ),
        Expanded(
          flex: 10,
          child: Text(
            label,
            style: theme.textTheme.bodyText2!.copyWith(
              color: isInvalidCase ? theme.errorColor : CustomColors.grey4,
              height: 1.2,
            ),
            textHeightBehavior: const TextHeightBehavior(
                leadingDistribution: TextLeadingDistribution.even),
          ),
        )
      ],
    );
  }
}
