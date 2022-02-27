import 'package:app_ui/app_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// {@macro app_theme}
/// The Default App UI [ThemeData].
/// {endtemplate}
class AppTheme {
  /// {@app_theme}
  const AppTheme();

  /// Default `ThemeData` for App UI.
  ThemeData get themeData {
    return ThemeData(
      primaryColor: CustomColors.primaryColor,
      primaryColorLight: CustomColors.primaryColorLight,
      canvasColor: _backgroundColor,
      backgroundColor: _backgroundColor,
      scaffoldBackgroundColor: _backgroundColor,
      iconTheme: _iconTheme,
      appBarTheme: _appBarTheme,
      dividerTheme: _dividerTheme,
      textTheme: _textTheme,
      inputDecorationTheme: _inputDecorationTheme,
      buttonTheme: _buttonTheme,
      splashColor: CustomColors.transparent,
      snackBarTheme: _snackBarTheme,
      elevatedButtonTheme: _elevatedButtonTheme,
      textButtonTheme: _textButtonTheme,
      colorScheme: _colorScheme,
      textSelectionTheme: _textSelectionTheme,
      cupertinoOverrideTheme: _cupertinoThemeData,
    );
  }

  TextSelectionThemeData get _textSelectionTheme =>
      const TextSelectionThemeData(
        cursorColor: CustomColors.primaryColor,
        selectionColor: CustomColors.primaryDarkColor,
      );

  CupertinoThemeData get _cupertinoThemeData =>
      const CupertinoThemeData(primaryColor: CustomColors.primaryDarkColor);

  ColorScheme get _colorScheme {
    return const ColorScheme.light(secondary: CustomColors.secondaryColor);
  }

  SnackBarThemeData get _snackBarTheme {
    return SnackBarThemeData(
      contentTextStyle: AppTextStyle.bodyText1.copyWith(
        color: CustomColors.white,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSpacing.sm),
      ),
      actionTextColor: CustomColors.primaryColor,
      backgroundColor: CustomColors.black,
      elevation: 4,
      behavior: SnackBarBehavior.floating,
    );
  }

  Color get _backgroundColor => CustomColors.white;

  AppBarTheme get _appBarTheme {
    return AppBarTheme(
      iconTheme: _iconTheme,
      titleTextStyle: _textTheme.headline5,
      toolbarTextStyle: _textTheme.headline5,
      elevation: 0,
      backgroundColor: CustomColors.transparent,
    );
  }

  IconThemeData get _iconTheme {
    return const IconThemeData(color: CustomColors.black);
  }

  DividerThemeData get _dividerTheme {
    return const DividerThemeData(
      color: CustomColors.grey3,
      space: AppSpacing.xxxs,
      thickness: AppSpacing.xxxs,
      indent: 56,
      endIndent: AppSpacing.lg,
    );
  }

  TextTheme get _textTheme {
    return TextTheme(
      headline1: AppTextStyle.headline1,
      headline2: AppTextStyle.headline2,
      headline3: AppTextStyle.headline3,
      headline4: AppTextStyle.headline4,
      headline5: AppTextStyle.headline5,
      headline6: AppTextStyle.headline6,
      subtitle1: AppTextStyle.subtitle1,
      subtitle2: AppTextStyle.subtitle2,
      bodyText1: AppTextStyle.bodyText1,
      bodyText2: AppTextStyle.bodyText2,
      button: AppTextStyle.button,
      caption: AppTextStyle.caption,
      overline: AppTextStyle.overline,
    ).apply(
      bodyColor: CustomColors.black,
      displayColor: CustomColors.black,
      decorationColor: CustomColors.black,
    );
  }

  InputDecorationTheme get _inputDecorationTheme {
    return const InputDecorationTheme(
      border: UnderlineInputBorder(
        borderSide: BorderSide(
          width: 2,
          color: CustomColors.dimGrey,
        ),
      ),
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          width: 2,
          color: CustomColors.dimGrey,
        ),
      ),
      errorBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: CustomColors.errorColor,
          width: 2,
        ),
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: CustomColors.primaryColor,
          width: 2,
        ),
      ),
      focusedErrorBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: CustomColors.errorColor,
          width: 2,
        ),
      ),
      disabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          width: 2,
          color: CustomColors.dimGrey,
        ),
      ),
      hintStyle: TextStyle(
        color: CustomColors.primaryColor,
        fontSize: 11,
      ),
    );
  }

  ButtonThemeData get _buttonTheme {
    return ButtonThemeData(
      textTheme: ButtonTextTheme.primary,
      buttonColor: CustomColors.primaryColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSpacing.sm),
      ),
    );
  }

  ElevatedButtonThemeData get _elevatedButtonTheme {
    return ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith<Color>(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.disabled)) {
              return CustomColors.primaryColorLight;
            }
            if (states.contains(MaterialState.pressed)) {
              return CustomColors.primaryDarkColor;
            }
            return CustomColors.primaryColor;
          },
        ),
        elevation: MaterialStateProperty.resolveWith<double>((_) => 0),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(12),
            ),
          ),
        ),
        padding: MaterialStateProperty.all<EdgeInsets?>(
          const EdgeInsets.symmetric(vertical: AppSpacing.lg),
        ),
        textStyle: MaterialStateProperty.all<TextStyle?>(
          _textTheme.button,
        ),
      ),
    );
  }

  TextButtonThemeData get _textButtonTheme {
    return TextButtonThemeData(
      style: TextButton.styleFrom(
        textStyle: _textTheme.button?.copyWith(
          fontWeight: AppFontWeight.light,
        ),
        primary: CustomColors.black,
      ),
    );
  }
}

/// {@macro app_dark_theme}
/// Dark Modes [ThemeData].
/// {@endtemplate}
class AppDarkTheme extends AppTheme {
  /// {@app_dark_theme}
  const AppDarkTheme();

  @override
  ColorScheme get _colorScheme {
    return const ColorScheme.dark().copyWith(
      primary: CustomColors.white,
      secondary: CustomColors.secondaryColor,
    );
  }

  @override
  TextTheme get _textTheme {
    return super._textTheme.apply(
          bodyColor: CustomColors.white,
          displayColor: CustomColors.white,
          decorationColor: CustomColors.white,
        );
  }

  @override
  SnackBarThemeData get _snackBarTheme {
    return SnackBarThemeData(
      contentTextStyle: AppTextStyle.bodyText1.copyWith(
        color: CustomColors.black,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSpacing.sm),
      ),
      actionTextColor: CustomColors.white,
      backgroundColor: CustomColors.mediumGrey,
      elevation: 4,
      behavior: SnackBarBehavior.floating,
    );
  }

  @override
  TextButtonThemeData get _textButtonTheme {
    return TextButtonThemeData(
      style: TextButton.styleFrom(
        textStyle: _textTheme.button?.copyWith(
          fontWeight: AppFontWeight.light,
        ),
        primary: CustomColors.white,
      ),
    );
  }

  @override
  Color get _backgroundColor => CustomColors.black;

  @override
  IconThemeData get _iconTheme {
    return const IconThemeData(color: CustomColors.white);
  }

  @override
  DividerThemeData get _dividerTheme {
    return const DividerThemeData(
      color: CustomColors.dimGrey,
      space: AppSpacing.xxxs,
      thickness: AppSpacing.xxxs,
      indent: 56,
      endIndent: AppSpacing.lg,
    );
  }
}
