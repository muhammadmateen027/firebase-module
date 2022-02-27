import 'dart:async';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

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
    on<AppUserChanged>(_mapUserChangedToState);
    on<AppLogoutRequested>((event, emit) => _authenticationRepository.logOut());
  }

  final AuthenticationRepository _authenticationRepository;
  late StreamSubscription<User> _userSubscription;
  void _onUserChanged(User user) => add(AppUserChanged(user));

  Future<void> _mapUserChangedToState(
      AppUserChanged event, Emitter<AppState> emit) async {
    if (event.user == User.anonymous) {
      emit(const AppState.unauthenticated());
      return;
    }

    if (event.user.isNewUser) {
      emit(AppState.newAccount(event.user));
      return;
    }

    if (!await _authenticationRepository.isUserWithHandle(event.user)) {
      emit(AppState.newAccount(event.user));
      return;
    }

    emit(AppState.authenticated(event.user));
  }

  @override
  Future<void> close() {
    _userSubscription.cancel();
    return super.close();
  }
}
