import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// This class will be used to define create post title text
class PostTitle extends StatefulWidget {
  /// {@macro post_title}
  const PostTitle({
    required this.onChanged,
    this.hintText,
    this.onSubmitted,
    this.autoCorrect = false,
    this.maxLength = 50,
    this.text = '',
    Key? key,
  }) : super(key: key);

  ///onChanged method to be call after changes in [InputTextField]
  final ValueChanged<String>? onChanged;

  /// hintText used to identify [InputTextField]
  final String? hintText;

  /// Callback function called when submit
  final ValueChanged<String>? onSubmitted;

  /// Callback function called when submit
  // final ValueChanged<String>? validator;

  /// Whether to enable auto correction. Defaults to true. Cannot be null.
  final bool autoCorrect;

  ///  The [maxLength] number of characters (Unicode scalar values) to allow
  // in the text field.
  final int maxLength;

  /// The current title of the post
  final String text;

  @override
  _PostTitle createState() => _PostTitle();
}

class _PostTitle extends State<PostTitle> {
  late TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    controller.value = controller.value.copyWith(text: widget.text);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: TextField(
        smartDashesType: SmartDashesType.disabled,
        maxLengthEnforcement: MaxLengthEnforcement.enforced,
        textInputAction: TextInputAction.done,
        inputFormatters: [
          LengthLimitingTextInputFormatter(widget.maxLength),
        ],
        maxLines: 2,
        onChanged: widget.onChanged,
        keyboardType: TextInputType.text,
        style: AppTextStyle.headline5,
        decoration: InputDecoration(
          hintStyle: AppTextStyle.headline5.copyWith(
            color: CustomColors.mediumGrey,
            fontWeight: FontWeight.w700,
          ),
          prefixIconConstraints: const BoxConstraints(
            maxHeight: 50,
            maxWidth: 50,
          ),
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 4),
          hintText: widget.hintText,
        ),
        onSubmitted: widget.onSubmitted,
        autocorrect: widget.autoCorrect,
        controller: controller,
      ),
    );
  }
}
