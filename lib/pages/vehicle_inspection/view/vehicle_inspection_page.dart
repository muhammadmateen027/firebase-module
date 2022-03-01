import 'package:app_ui/app_ui.dart';
import 'package:assignment/pages/pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VehicleInspectionPage extends StatelessWidget {
  const VehicleInspectionPage({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute<void>(
      builder: (_) => const VehicleInspectionPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: AppSpacing.sm,
          horizontal: AppSpacing.xlg,
        ),
        child: BlocProvider(
          create: (_) => VehicleInspectionBloc(),
          child: const VehicleInspectionForm(),
        ),
      ),
    );
  }
}
