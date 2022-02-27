import 'dart:async';

import 'package:app_ui/app_ui.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:very_good_analysis/very_good_analysis.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc({
    required AuthenticationRepository authenticationRepository,
    required User user,
  })  : _authenticationRepository = authenticationRepository,
        super(
          user == User.anonymous
              ? const AppState.unauthenticated()
              : AppState.authenticated(user),
        ) {
    _userSubscription = _authenticationRepository.user.listen(_onUserChanged);

    on<AppDownForMaintenanceStatusChanged>(
      _handleAppDownForMaintenanceStatusChanged,
    );
    on<AppUserChanged>(_handleUserChangedToState);
    on<NewAccountCreated>(_handleNewAccountCreated);
    on<AppLogoutRequested>(
      (event, emit) => unawaited(_authenticationRepository.logOut()),
    );
    on<ShowLoadingOverlayEvent>(_showLoadingOverlayToState);
    on<HideLoadingOverlayEvent>(_hideLoadingOverlayToState);
  }

  final AuthenticationRepository _authenticationRepository;
  late StreamSubscription<bool> _isDownForMaintenanceSubscription;
  late StreamSubscription<User> _userSubscription;

  final whiteOverlay = OverlayEntry(
    builder: (context) {
      return Container(
        color: CustomColors.white.withOpacity(.8),
      );
    },
  );

  void _onUserChanged(User user) => add(AppUserChanged(user));

  void _handleAppDownForMaintenanceStatusChanged(
    AppDownForMaintenanceStatusChanged event,
    Emitter<AppState> emit,
  ) {
    if (event.isDownForMaintenance) {
      emit(AppState.downForMaintenance(state.user));
    } else if (state.status != AppStatus.downForMaintenance) {
      emit(state);
    } else {
      emit(
        state.user == User.anonymous
            ? const AppState.unauthenticated()
            : AppState.authenticated(state.user),
      );
    }
  }

  Future<void> _handleUserChangedToState(
    AppUserChanged event,
    Emitter<AppState> emit,
  ) async {
    if (event.user == User.anonymous) {
      emit(const AppState.unauthenticated());
    } else if (!await _authenticationRepository.isUserWithHandle(event.user)) {
      emit(AppState.newAccount(event.user));
    } else {
      emit(AppState.authenticated(event.user));
    }
  }

  void _handleNewAccountCreated(
    NewAccountCreated event,
    Emitter<AppState> emit,
  ) {
    emit(
      state.user == User.anonymous
          ? const AppState.unauthenticated()
          : AppState.authenticated(state.user),
    );
  }

  @override
  Future<void> close() {
    _isDownForMaintenanceSubscription.cancel();
    _userSubscription.cancel();
    return super.close();
  }

  FutureOr<void> _showLoadingOverlayToState(
    ShowLoadingOverlayEvent event,
    Emitter<AppState> emit,
  ) {
    final overlay = Overlay.of(event.context);
    if (overlay != null && !state.showingLoadingOverlay) {
      overlay.insertAll([whiteOverlay]);
      emit(state.copyWith(showingLoadingOverlay: true));
    }
  }

  FutureOr<void> _hideLoadingOverlayToState(
    HideLoadingOverlayEvent event,
    Emitter<AppState> emit,
  ) {
    if (state.showingLoadingOverlay) {
      whiteOverlay.remove();
      emit(state.copyWith(showingLoadingOverlay: false));
    }
  }
}
