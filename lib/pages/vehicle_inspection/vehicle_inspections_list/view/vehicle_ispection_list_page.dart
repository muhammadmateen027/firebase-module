import 'package:assignment/l10n/l10n.dart';
import 'package:flutter/material.dart';

class VehicleInspectionListPage extends StatelessWidget {
  const VehicleInspectionListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ListView.separated(
          itemBuilder: (_, index) {
            return ListTile(
              title: Text('$index'),
            );
          },
          separatorBuilder: (_, index) => const Divider(),
          itemCount: 30,
        ),
        Center(
          child: Text(context.l10n.itemUnderDevelopmentMessage),
        ),
      ],
    );
  }
}
