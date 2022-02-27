import 'package:assignment/app/app.dart';
import 'package:assignment/pages/pages.dart';
import 'package:flutter/material.dart';

List<Page> onGenerateAppViewPages(AppStatus state, List<Page<dynamic>> pages) {
  switch (state) {
    case AppStatus.authenticated:
      return [DashboardPage.page()];
    case AppStatus.newAccountRequired:
      return [NewAccountPage.page()];
    case AppStatus.downForMaintenance:
    case AppStatus.forceUpgradeRequired:
    case AppStatus.unauthenticated:
      return [LoginPage.page()];
  }
}
