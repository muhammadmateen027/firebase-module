// Copyright (c) 2021, Very Good Ventures
// https://verygood.ventures

part of 'app_bloc.dart';

abstract class AppEvent extends Equatable {
  const AppEvent();

  @override
  List<Object> get props => [];
}

class AppLogoutRequested extends AppEvent {}

class NewAccountCreated extends AppEvent {}

class AppDownForMaintenanceStatusChanged extends AppEvent {
  @visibleForTesting
  const AppDownForMaintenanceStatusChanged({this.isDownForMaintenance = false});

  final bool isDownForMaintenance;

  @override
  List<Object> get props => [isDownForMaintenance];
}

class AppUserChanged extends AppEvent {
  @visibleForTesting
  const AppUserChanged(this.user);

  final User user;

  @override
  List<Object> get props => [user];
}

class ShowLoadingOverlayEvent extends AppEvent {
  const ShowLoadingOverlayEvent({required this.context});

  final BuildContext context;
}

class HideLoadingOverlayEvent extends AppEvent {}
