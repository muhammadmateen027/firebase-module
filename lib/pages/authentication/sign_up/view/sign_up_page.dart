import 'package:app_ui/app_ui.dart';
import 'package:assignment/l10n/l10n.dart';
import 'package:assignment/pages/authentication/sign_up/sign_up.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const SignUpPage());
  }

  static Page page() => const MaterialPage<void>(child: SignUpPage());

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = context.l10n;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          l10n.signUpAppBarTitle,
          style: theme.textTheme.headline2,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: AppSpacing.xxxlg,
          horizontal: AppSpacing.xlg,
        ),
        child: BlocProvider<SignUpBloc>(
          create: (_) => SignUpBloc(context.read<AuthenticationRepository>()),
          child: const SignUpForm(),
        ),
      ),
    );
  }
}
