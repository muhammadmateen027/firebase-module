import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Widget to being used for the post creating
class PostDescription extends StatefulWidget {
  /// @{post_description}
  const PostDescription({
    Key? key,
    required this.onChanged,
    this.maxLength = 1500,
    this.hintText = '',
    this.controller,
    this.text = '',
    this.hintMaxLines,
  }) : super(key: key);

  /// listen changes from the text field
  final ValueChanged<String>? onChanged;

  /// maximum length of the text field
  final int maxLength;

  /// Hint to be shown in text field
  final String hintText;

  /// The maximum lines the hint can occupy.
  final int? hintMaxLines;

  /// If null, this widget will create its own [TextEditingController] and
  /// initialize its [TextEditingController.text] with [initial Value].
  final TextEditingController? controller;

  /// To get the new value for the controller
  final String text;

  @override
  _PostDescription createState() => _PostDescription();
}

class _PostDescription extends State<PostDescription> {
  late TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    //Set the value and cursor at the point
    controller.value = controller.value.copyWith(text: widget.text);

    return ConstrainedBox(
      constraints: const BoxConstraints(minHeight: 150),
      child: TextFormField(
        controller: controller,
        style: theme.textTheme.headline5!.copyWith(
          fontWeight: AppFontWeight.regular,
          letterSpacing: 0.5,
        ),
        scrollPhysics: const BouncingScrollPhysics(),
        onChanged: widget.onChanged,
        inputFormatters: [
          LengthLimitingTextInputFormatter(widget.maxLength),
        ],
        decoration: InputDecoration(
          hintStyle: theme.textTheme.headline5!.copyWith(
            color: CustomColors.grey4,
            letterSpacing: 0.5,
            fontSize: 16,
            fontWeight: AppFontWeight.regular,
          ),
          hintText: widget.hintText,
          hintMaxLines: widget.hintMaxLines,
          counterText: '',
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          focusColor: CustomColors.lightGrey,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.lg,
            vertical: AppSpacing.md,
          ),
        ),
        maxLengthEnforcement: MaxLengthEnforcement.enforced,
        maxLines: null,
        keyboardType: TextInputType.multiline,
        textInputAction: TextInputAction.newline,
      ),
    );
  }
}
