import 'package:app_ui/app_ui.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AppTheme', () {
    group('themeData', () {
      test('primary color is orange', () {
        expect(
          const AppTheme().themeData.primaryColor,
          CustomColors.primaryColor,
        );
      });

      test('secondary color is teal', () {
        expect(
          const AppTheme().themeData.colorScheme.secondary,
          CustomColors.secondaryColor,
        );
      });
    });
  });

  group('AppDarkTheme', () {
    group('themeData', () {
      test('primary color is orange', () {
        expect(
          const AppDarkTheme().themeData.primaryColor,
          CustomColors.primaryColor,
        );
      });

      test('secondary color is teal', () {
        expect(
          const AppDarkTheme().themeData.colorScheme.secondary,
          CustomColors.secondaryColor,
        );
      });

      test('background color is grey.shade900', () {
        expect(
          const AppDarkTheme().themeData.backgroundColor,
          CustomColors.black,
        );
      });
    });
  });
}
