import 'package:assignment/app/app.dart';
import 'package:assignment/pages/pages.dart';
import 'package:assignment/utilities/theme_selector/bloc/theme_mode_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  static Page page() => const MaterialPage<void>(child: DashboardPage());

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int _selectedIndex = 0;
  static const List<Widget> _pages = <Widget>[
    Icon(
      Icons.call,
      size: 150,
    ),
    Icon(
      Icons.camera,
      size: 150,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        actions: const [
          _LogoutButton(),
          _ThemeSelectorButton(
            key: Key('dashboardPage_lightTheme_selector'),
            themeMode: ThemeMode.light,
          ),
          _ThemeSelectorButton(
            key: Key('dashboardPage_darkTheme_selector'),
            themeMode: ThemeMode.dark,
            icon: Icons.dark_mode,
          ),
        ],
      ),
      body: Center(
        child: _pages.elementAt(_selectedIndex), //New
      ),
      bottomNavigationBar: _BottomNavigationMenu(
        onTap: _onItemTapped,
        selectedIndex: _selectedIndex,
      ),
      floatingActionButton: const _FloatingActionButton(),
    );
  }

  void _onItemTapped(int index) => setState(() => _selectedIndex = index);
}

class _FloatingActionButton extends StatelessWidget {
  const _FloatingActionButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => Navigator.of(context).push<void>(
        VehicleInspectionPage.route(),
      ),
      backgroundColor:
          Theme.of(context).primaryColor,
      child: const Icon(
        Icons.add,
      ),
    );
  }
}

class _BottomNavigationMenu extends StatelessWidget {
  const _BottomNavigationMenu({
    Key? key,
    required this.onTap,
    required this.selectedIndex,
  }) : super(key: key);
  final ValueChanged<int>? onTap;
  final int selectedIndex;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Theme.of(context).primaryColorLight,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.message),
          label: 'Inspections',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
      ],
      currentIndex: selectedIndex,
      onTap: onTap,
    );
  }
}

class _LogoutButton extends StatelessWidget {
  const _LogoutButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      key: const Key('dashboardPage_logout_iconButton'),
      icon: const Icon(Icons.logout),
      onPressed: () => context.read<AppBloc>().add(AppLogoutRequested()),
    );
  }
}

class _ThemeSelectorButton extends StatelessWidget {
  const _ThemeSelectorButton({
    required this.themeMode,
    this.icon,
    Key? key,
  }) : super(key: key);
  final ThemeMode themeMode;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      key: const Key('counterPage_logout_iconButton'),
      icon: Icon(icon ?? Icons.light_mode),
      onPressed: () => context.read<ThemeModeBloc>().add(
            ThemeModeChanged(themeMode),
          ),
    );
  }
}
