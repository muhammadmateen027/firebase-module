import 'package:app_ui/app_ui.dart';
import 'package:assignment/l10n/l10n.dart';
import 'package:assignment/pages/pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_inputs/form_inputs.dart';

class VehicleInspectionForm extends StatelessWidget {
  const VehicleInspectionForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final localizations = context.l10n;
    return BlocListener<VehicleInspectionBloc, VehicleInspectionState>(
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
        Text(l10n.inspectionPageTitle, style: theme.textTheme.headline1),
        const SizedBox(height: AppSpacing.md),
        Text(l10n.inspectionFormMessage, style: theme.textTheme.headline6),
        const SizedBox(height: AppSpacing.xxlg),
        const _ImageView(),
        const SizedBox(height: AppSpacing.xxlg),
        _IdentificationNumberInput(),
        const SizedBox(height: AppSpacing.lg),
        _MakeInput(),
        const SizedBox(height: AppSpacing.lg),
        _ModelTextInput(),
        const SizedBox(height: AppSpacing.lg),
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
        _SubmitButton(),
        const SizedBox(height: AppSpacing.xlg),
        const SizedBox(height: AppSpacing.xxlg),
      ],
    );
  }
}

class _IdentificationNumberInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final localizations = context.l10n;
    return InputTextField(
      key: const Key('inspectionForm_identificationNumber_textField'),
      onChanged: (String value) {},
      hintText: localizations.identificationNumberLabel,
    );
  }
}

class _MakeInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final localizations = context.l10n;
    return InputTextField(
      key: const Key('inspectionForm_vehicleMake_textField'),
      onChanged: (String value) {},
      hintText: localizations.vehicleMakeLabel,
    );
  }
}

class _ModelTextInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final localizations = context.l10n;
    return InputTextField(
      key: const Key('inspectionForm_vehicleModel_textField'),
      onChanged: (String value) {},
      hintText: localizations.vehicleModelLabel,
    );
  }
}

class _ImageView extends StatelessWidget {
  const _ImageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.lg,
        AppSpacing.lg,
        AppSpacing.lg,
        0,
      ),
      child: const CircleImageView(
        imageProvider: ExactAssetImage(
          'assets/images/profile.png',
        ),
      ),
    );
  }
}

class _SubmitButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final localizations = context.l10n;
    return BlocBuilder<VehicleInspectionBloc, VehicleInspectionState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return ElevatedButton(
          key: const Key('loginForm_continue_elevatedButton'),
          onPressed: () {},
          child: state.status.isSubmissionInProgress
              ? const CircularProgressIndicator()
              : Text(localizations.submitButtonLagel),
        );
      },
    );
  }
}
