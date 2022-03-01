import 'package:assignment/l10n/l10n.dart';
import 'package:flutter/material.dart';


class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Material(child: _ProfilePageView());
  }
}

class _ProfilePageView extends StatelessWidget {
  const _ProfilePageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).colorScheme.background,
      child: Center(
        child: Text(context.l10n.itemUnderDevelopmentMessage),
      ),
    );
  }
}
