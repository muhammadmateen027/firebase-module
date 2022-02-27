import 'package:app_ui/app_ui.dart';
import 'package:assignment/pages/authentication/login/login.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  static Page page() => const MaterialPage<void>(child: LoginPage());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: AppSpacing.xxxlg,
            horizontal: AppSpacing.xlg,
          ),
          child: BlocProvider(
            create: (_) => LoginBloc(context.read<AuthenticationRepository>()),
            child: const LoginForm(),
          ),
        ),
      ),
    );
  }
}
