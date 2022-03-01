import 'package:app_ui/app_ui.dart';
import 'package:assignment/l10n/l10n.dart';
import 'package:assignment/pages/authentication/authentication.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';


class ResetPasswordForm extends StatelessWidget {
  const ResetPasswordForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final localizations = context.l10n;
    return BlocListener<ResetPasswordBloc, ResetPasswordState>(
      listener: (context, state) {
        if (state.status.isSubmissionSuccess ||
            state.status.isSubmissionFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(content: Text(localizations.resetPasswordSubmitText)),
            );
          Navigator.of(context).pop();
        }
      },
      child: const ScrollableColumn(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _EmailInput(),
          SizedBox(height: AppSpacing.xlg),
          _SubmitButton(),
        ],
      ),
    );
  }
}

class _EmailInput extends StatelessWidget {
  const _EmailInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final localizations = context.l10n;
    final email = context.select((ResetPasswordBloc bloc) => bloc.state.email);
    return InputTextField(
      key: const Key('resetPasswordForm_emailInput_textField'),
      onChanged: (email) {
        context.read<ResetPasswordBloc>().add(ResetPasswordEmailChanged(email));
      },
      hintText: localizations.emailInputLabelText,
      errorText:
      email.invalid ? localizations.invalidEmailInputErrorText : null,
      keyboardType: TextInputType.emailAddress,
    );
  }
}

class _SubmitButton extends StatelessWidget {
  const _SubmitButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final localizations = context.l10n;
    final status =
    context.select((ResetPasswordBloc bloc) => bloc.state.status);
    return ElevatedButton(
      key: const Key('submitResetPassword_continue_elevatedButton'),
      onPressed: status.isValidated
          ? () => context
          .read<ResetPasswordBloc>()
          .add(const ResetPasswordSubmitted())
          : null,
      child: status.isSubmissionInProgress
          ? const CircularProgressIndicator()
          : Text(localizations.submitButtonLabel),
    );
  }
}