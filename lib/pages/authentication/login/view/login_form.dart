import 'package:app_ui/app_ui.dart';
import 'package:assignment/l10n/l10n.dart';
import 'package:assignment/pages/pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final localizations = context.l10n;
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state.status.isSubmissionFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(content: Text(localizations.authenticationFailure)),
            );
        }
      },
      child: const ScrollableColumn(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _LoginContent(),
          _LoginActions(),
        ],
      ),
    );
  }
}

class _LoginContent extends StatelessWidget {
  const _LoginContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = context.l10n;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text('CarOnSale', style: theme.textTheme.headline6),
        const SizedBox(height: AppSpacing.xlg),
        Text(l10n.loginWelcomeText, style: theme.textTheme.headline1),
        const SizedBox(height: AppSpacing.xxlg),
        _EmailInput(),
        const SizedBox(height: AppSpacing.xs),
        _PasswordInput(),
        const SizedBox(height: AppSpacing.xs),
        _ResetPasswordButton(),
      ],
    );
  }
}

class _LoginActions extends StatelessWidget {
  const _LoginActions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _LoginButton(),
        const SizedBox(height: AppSpacing.xlg),
        const SizedBox(height: AppSpacing.xxlg),
        _SignUpButton(),
      ],
    );
  }
}

class _EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final localizations = context.l10n;
    final email = context.select((LoginBloc bloc) => bloc.state.email);
    return TextField(
      key: const Key('loginForm_emailInput_textField'),
      onChanged: (email) {
        context.read<LoginBloc>().add(LoginEmailChanged(email));
      },
      decoration: InputDecoration(
        helperText: '',
        labelText: localizations.emailInputLabelText,
        errorText:
            email.invalid ? localizations.invalidEmailInputErrorText : null,
      ),
      autocorrect: false,
    );
  }
}

class _PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final localizations = context.l10n;
    final password = context.select((LoginBloc bloc) => bloc.state.password);
    return TextField(
      key: const Key('loginForm_passwordInput_textField'),
      onChanged: (password) {
        context.read<LoginBloc>().add(LoginPasswordChanged(password));
      },
      obscureText: true,
      decoration: InputDecoration(
        helperText: '',
        labelText: localizations.passwordInputLabelText,
        errorText: password.invalid
            ? localizations.invalidPasswordInputErrorText
            : null,
      ),
    );
  }
}

class _LoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final localizations = context.l10n;
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return ElevatedButton(
          key: const Key('loginForm_continue_elevatedButton'),
          onPressed: state.email.valid && state.password.valid
              ? () => context.read<LoginBloc>().add(LoginCredentialsSubmitted())
              : null,
          child: state.status.isSubmissionInProgress
              ? const CircularProgressIndicator()
              : Text(localizations.loginButtonText),
        );
      },
    );
  }
}

class _SignUpButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final localizations = context.l10n;
    return TextButton(
      key: const Key('loginForm_createAccount_textButton'),
      onPressed: () => Navigator.of(context).push<void>(SignUpPage.route()),
      child: Text(localizations.createAccountButtonText),
    );
  }
}

class _ResetPasswordButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final localizations = context.l10n;
    return TextButton(
      key: const Key('loginForm_forgotPassword_textButton'),
      onPressed: null,
      child: Text(localizations.forgotPasswordText),
    );
  }
}
