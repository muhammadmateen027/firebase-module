import 'package:app_ui/app_ui.dart';
import 'package:assignment/app/app.dart';
import 'package:assignment/l10n/l10n.dart';
import 'package:assignment/pages/authentication/authentication.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_inputs/form_inputs.dart';

class NewAccountForm extends StatelessWidget {
  const NewAccountForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final localizations = context.l10n;
    return WillPopScope(
      onWillPop: () async => false,
      child: BlocListener<NewAccountBloc, NewAccountState>(
        listener: (context, state) {
          if (state.status == NewAccountStatusCode.submissionSuccess) {
            context.read<AppBloc>().add(NewAccountCreated());
          }
          if (state.status == NewAccountStatusCode.submissionFailure) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(content: Text(localizations.signUpFailure)),
              );
          }
        },
        child: const ScrollableColumn(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _NewAccountContent(),
            _SignUpButton(),
          ],
        ),
      ),
    );
  }
}

class _NewAccountContent extends StatelessWidget {
  const _NewAccountContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        SizedBox(height: AppSpacing.xlg),
        _Header(),
        SizedBox(height: AppSpacing.xlg),
        _FullNameInput(),
        SizedBox(height: AppSpacing.xlg),
        _UsernameInput(),
      ],
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.newAccountTitle,
          style: AppTextStyle.headline1
              .copyWith(fontSize: 24, color: CustomColors.dimGrey),
        ),
        const SizedBox(height: AppSpacing.lg),
        Text.rich(
          TextSpan(
            text: l10n.newAccountSubtitle,
            style: AppTextStyle.bodyText1.copyWith(
              color: CustomColors.grey4,
              fontSize: 13,
            ),
          ),
        ),
      ],
    );
  }
}

class _FullNameInput extends StatelessWidget {
  const _FullNameInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.select((NewAccountBloc element) => element.state.status);
    final bloc = context.read<NewAccountBloc>();

    return InputTextField(
      errorText: bloc.state.showErrors
          ? _getErrorMessage(context.l10n, bloc.state)
          : null,
      maxLength: 24,
      key: const Key('newAccountForm_fullNameInput_textField'),
      onChanged: (value) =>
          bloc.add(NewAccountFullNameChanged(FullName.dirty(value))),
      hintText: context.l10n.userFullNameInputLabelText,
      prefixIcon: const Icon(Icons.person),
    );
  }

  String? _getErrorMessage(AppLocalizations l10n, NewAccountState state) {
    if (state.fullName.invalid) {
      return null;
    }

    return l10n.invalidFullNameInputErrorText;
  }
}

class _UsernameInput extends StatelessWidget {
  const _UsernameInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final bloc = context.read<NewAccountBloc>();

    context.select((NewAccountBloc element) => element.state.status);

    return InputTextField(
      key: const Key('newAccountForm_idInput_textField'),
      prefixIcon: const Icon(Icons.person_add_alt_1_outlined),
      hintText: l10n.userIdInputLabelText,
      errorText:
      bloc.state.showErrors ? _getErrorMessage(l10n, bloc.state) : null,
      onChanged: (value) => bloc.add(
        NewAccountHandleChanged(Handle.dirty(value.toLowerCase())),
      ),
    );
  }

  String? _getErrorMessage(AppLocalizations l10n, NewAccountState state) {
    if (state.status == NewAccountStatusCode.userNameAlreadyExists) {
      return l10n.usernameAlreadyExists;
    } else if (state.handle.invalid) {
      return l10n.invalidUsernameInputErrorText;
    }

    return null;
  }
}

class _SignUpButton extends StatelessWidget {
  const _SignUpButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final status = context.select((NewAccountBloc bloc) => bloc.state.status);
    final user = context.read<AppBloc>().state.user;

    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.xlg),
      child: PrimaryButton(
        onPressed: _isEnabledToSubmit(status)
            ? () => context
            .read<NewAccountBloc>()
            .add(NewAccountSubmitted(user))
            : null,
        label: context.l10n.createAccountButtonText,
        isLoading: status == NewAccountStatusCode.submissionInProgress,
      ),
    );
  }

  bool _isEnabledToSubmit(NewAccountStatusCode code) =>
      code == NewAccountStatusCode.readyToSubmit;
}
