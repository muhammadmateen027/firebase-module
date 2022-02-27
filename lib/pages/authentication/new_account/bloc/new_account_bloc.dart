import 'dart:async';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:form_inputs/form_inputs.dart';

part 'new_account_event.dart';

part 'new_account_state.dart';

class NewAccountBloc extends Bloc<NewAccountEvent, NewAccountState> {
  NewAccountBloc(this._authenticationRepository)
      : super(const NewAccountState()) {
    on<NewAccountHandleChanged>(_onHandleChanged);
    on<NewAccountFullNameChanged>(_onFullNameChanged);
    on<NewAccountSubmitted>(_onSubmitted);
  }

  final AuthenticationRepository _authenticationRepository;

  void _onFullNameChanged(
    NewAccountFullNameChanged event,
    Emitter<NewAccountState> emit,
  ) {
    final fullName = event.fullName;

    emit(
      state.copyWith(
        fullName: fullName,
        status: !event.fullName.pure && !state.handle.pure
            ? NewAccountStatusCode.readyToSubmit
            : NewAccountStatusCode.notReady,
      ),
    );
  }

  void _onHandleChanged(
    NewAccountHandleChanged event,
    Emitter<NewAccountState> emit,
  ) {
    final handle = event.handle;
    emit(
      state.copyWith(
        handle: handle,
        status: !event.handle.pure && !state.fullName.pure
            ? NewAccountStatusCode.readyToSubmit
            : NewAccountStatusCode.notReady,
      ),
    );
  }

  Future<void> _onSubmitted(
    NewAccountSubmitted event,
    Emitter<NewAccountState> emit,
  ) async {
    if (!_isValidForm()) {
      emit(state.copyWith(status: NewAccountStatusCode.validationError));
      return;
    }

    emit(state.copyWith(status: NewAccountStatusCode.submissionInProgress));
    try {
      if (await _authenticationRepository.isUserNameExists(
        state.handle.value,
      )) {
        emit(
          state.copyWith(status: NewAccountStatusCode.userNameAlreadyExists),
        );
        return;
      }

      await _authenticationRepository.createUser(
        event.user,
        state.handle.value,
        state.fullName.value,
      );
      emit(
        state.copyWith(
          status: NewAccountStatusCode.submissionSuccess,
        ),
      );
    } on Exception {
      emit(
        state.copyWith(status: NewAccountStatusCode.submissionFailure),
      );
    }
  }

  bool _isValidForm() => state.fullName.valid && state.handle.valid;
}
