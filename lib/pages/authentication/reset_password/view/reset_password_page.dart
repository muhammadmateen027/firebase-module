import 'package:app_ui/app_ui.dart';
import 'package:assignment/l10n/l10n.dart';
import 'package:assignment/pages/authentication/authentication.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class ResetPasswordPage extends StatelessWidget {
  const ResetPasswordPage({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const ResetPasswordPage());
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final localizations = context.l10n;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          localizations.resetPasswordTitle,
          style: theme.textTheme.headline2,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: AppSpacing.xxxlg,
          horizontal: AppSpacing.xlg,
        ),
        child: BlocProvider<ResetPasswordBloc>(
          create: (_) => ResetPasswordBloc(
            context.read<AuthenticationRepository>(),
          ),
          child: const ResetPasswordForm(),
        ),
      ),
    );
  }
}