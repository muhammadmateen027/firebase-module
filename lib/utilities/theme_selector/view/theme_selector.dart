import 'package:assignment/l10n/l10n.dart';
import 'package:assignment/utilities/utilities.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// A drop down menu to select a new [ThemeMode]
///
/// Requires a [ThemeModeBloc] to be provided in the widget tree
/// (usually above [MaterialApp])
class ThemeSelector extends StatelessWidget {
  const ThemeSelector({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeMode = context.watch<ThemeModeBloc>().state;

    return DropdownButton(
      key: const Key('themeSelector_dropdown'),
      onChanged: (ThemeMode? selectedThemeMode) => context
          .read<ThemeModeBloc>()
          .add(ThemeModeChanged(selectedThemeMode)),
      value: themeMode,
      items: [
        DropdownMenuItem(
          value: ThemeMode.system,
          child: Text(
            context.l10n.systemOption,
            key: const Key('themeSelector_system_dropdownMenuItem'),
          ),
        ),
        DropdownMenuItem(
          value: ThemeMode.light,
          child: Text(
            context.l10n.lightModeOption,
            key: const Key('themeSelector_light_dropdownMenuItem'),
          ),
        ),
        DropdownMenuItem(
          value: ThemeMode.dark,
          child: Text(
            context.l10n.darkModeOption,
            key: const Key('themeSelector_dark_dropdownMenuItem'),
          ),
        ),
      ],
    );
  }
}
