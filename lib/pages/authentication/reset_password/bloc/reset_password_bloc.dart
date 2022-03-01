import 'dart:async';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:form_inputs/form_inputs.dart';

part 'reset_password_event.dart';
part 'reset_password_state.dart';

class ResetPasswordBloc extends Bloc<ResetPasswordEvent, ResetPasswordState> {
  ResetPasswordBloc(this._authRepository) : super(const ResetPasswordState()) {
    on<ResetPasswordEmailChanged>(_mapEmailChangedToState);
    on<ResetPasswordSubmitted>(_mapSubmittedToState);
  }

  final AuthenticationRepository _authRepository;


  void _mapEmailChangedToState(
      ResetPasswordEmailChanged event,
      Emitter<ResetPasswordState> emit,
      ) {
    final email = Email.dirty(event.email);
    emit(state.copyWith(
      email: email,
      status: Formz.validate([email]),
    ),);
  }

  Future<void> _mapSubmittedToState(
      ResetPasswordSubmitted event,
      Emitter<ResetPasswordState> emit,

      ) async {
    if (!state.status.isValidated) return;
    emit(state.copyWith(status: FormzStatus.submissionInProgress));

    try {
      await _authRepository.sendPasswordResetEmail(email: state.email.value);
      emit(state.copyWith(status: FormzStatus.submissionSuccess));
    } on Exception {
      emit(state.copyWith(status: FormzStatus.submissionFailure));
    }
  }
}