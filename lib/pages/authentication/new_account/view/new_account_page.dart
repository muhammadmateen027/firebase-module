import 'package:app_ui/app_ui.dart';
import 'package:assignment/pages/authentication/authentication.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewAccountPage extends StatelessWidget {
  const NewAccountPage({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const NewAccountPage());
  }

  static Page page() => const MaterialPage<void>(child: NewAccountPage());

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
        statusBarColor: Colors.transparent,
      ),
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(
            left: AppSpacing.xlg,
            top: AppSpacing.xxxlg,
            right: AppSpacing.xlg,
          ),
          child: BlocProvider<NewAccountBloc>(
            create: (_) =>
                NewAccountBloc(context.read<AuthenticationRepository>()),
            child: const NewAccountForm(),
          ),
        ),
      ),
    );
  }
}
