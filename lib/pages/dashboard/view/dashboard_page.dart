import 'package:assignment/app/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({Key? key}) : super(key: key);
  static Page page() => const MaterialPage<void>(child: DashboardPage());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: const Center(child: _LogoutButton()),
    );
  }
}

class _LogoutButton extends StatelessWidget {
  const _LogoutButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      key: const Key('counterPage_logout_iconButton'),
      icon: const Icon(Icons.logout),
      onPressed: () => context.read<AppBloc>().add(AppLogoutRequested()),
    );
  }
}
