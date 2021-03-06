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
        Text(l10n.loginPageTitle, style: theme.textTheme.headline6),
        const SizedBox(height: AppSpacing.xlg),
        Text(l10n.loginWelcomeText, style: theme.textTheme.headline1),
        const SizedBox(height: AppSpacing.xxlg),
        _EmailInput(),
        const SizedBox(height: AppSpacing.xlg),
        _PasswordInput(),
        const SizedBox(height: AppSpacing.lg),
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
    return InputTextField(
      key: const Key('loginForm_emailInput_textField'),
      onChanged: (email) {
        context.read<LoginBloc>().add(LoginEmailChanged(email));
      },
      hintText: localizations.emailInputLabelText,
      errorText:
          email.invalid ? localizations.invalidEmailInputErrorText : null,
      keyboardType: TextInputType.emailAddress,
    );
  }
}

class _PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final localizations = context.l10n;
    final password = context.select((LoginBloc bloc) => bloc.state.password);
    return PasswordInputField(
      key: const Key('loginForm_passwordInput_textField'),
      onChanged: (password) {
        context.read<LoginBloc>().add(LoginPasswordChanged(password));
      },
      hintText: localizations.passwordInputLabelText,
      errorText:
          password.invalid ? localizations.invalidPasswordInputErrorText : null,
    );
  }
}

class _LoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return PrimaryButton(
          key: const Key('loginForm_continue_elevatedButton'),
          onPressed: state.email.valid && state.password.valid
              ? () => context.read<LoginBloc>().add(LoginCredentialsSubmitted())
              : null,
          label: context.l10n.loginButtonText,
          isLoading: state.status.isSubmissionInProgress,
        );
      },
    );
  }
}

class _SignUpButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return TextButton(
      key: const Key('loginForm_createAccount_textButton'),
      onPressed: () => Navigator.of(context).push<void>(SignUpPage.route()),
      child: Text(context.l10n.createAccountButtonText),
    );
  }
}

class _ResetPasswordButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      key: const Key('loginForm_forgotPassword_textButton'),
      onPressed: () => Navigator.of(context).push<void>(
        ResetPasswordPage.route(),
      ),
      child: Text(context.l10n.forgotPasswordText),
    );
  }
}
