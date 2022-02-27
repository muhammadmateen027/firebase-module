// Copyright (c) 2021, Very Good Ventures
// https://verygood.ventures

part of 'app_bloc.dart';

enum AppStatus {
  downForMaintenance,
  forceUpgradeRequired,
  newAccountRequired,
  authenticated,
  unauthenticated,
}

class AppState extends Equatable {
  const AppState._({
    required this.status,
    this.user = User.anonymous,
    this.showingLoadingOverlay = false,
  });

  const AppState.downForMaintenance([User user = User.anonymous])
      : this._(status: AppStatus.downForMaintenance, user: user);

  const AppState.forceUpgradeRequired([
    User user = User.anonymous,
  ]) : this._(
          status: AppStatus.forceUpgradeRequired,
          user: user,
        );

  const AppState.authenticated(User user)
      : this._(status: AppStatus.authenticated, user: user);

  const AppState.newAccount(User user)
      : this._(status: AppStatus.newAccountRequired, user: user);

  const AppState.unauthenticated() : this._(status: AppStatus.unauthenticated);

  final AppStatus status;
  final User user;
  final bool showingLoadingOverlay;

  @override
  List<Object> get props => [
        status,
        user,
        showingLoadingOverlay,
      ];

  AppState copyWith({
    AppStatus? status,
    User? user,
    bool? showingLoadingOverlay,
  }) {
    return AppState._(
      status: status ?? this.status,
      user: user ?? this.user,
      showingLoadingOverlay:
          showingLoadingOverlay ?? this.showingLoadingOverlay,
    );
  }
}
