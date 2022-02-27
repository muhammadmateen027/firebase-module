part of 'new_account_bloc.dart';

enum NewAccountStatusCode {
  notReady,
  readyToSubmit,
  validationError,
  userNameAlreadyExists,
  submissionInProgress,
  submissionSuccess,
  submissionFailure
}

class NewAccountState extends Equatable {
  const NewAccountState({
    this.status = NewAccountStatusCode.notReady,
    this.handle = const Handle.pure(),
    this.fullName = const FullName.pure(),
  });

  final NewAccountStatusCode status;
  final Handle handle;
  final FullName fullName;

  NewAccountState copyWith({
    NewAccountStatusCode? status,
    Handle? handle,
    FullName? fullName,
    bool? showErrors,
  }) {
    return NewAccountState(
      status: status ?? this.status,
      handle: handle ?? this.handle,
      fullName: fullName ?? this.fullName,
    );
  }

  @override
  List<Object?> get props => [
    handle,
    status,
    fullName,
  ];

  bool get isValid =>
      handle.valid &&
          fullName.valid &&
          status == NewAccountStatusCode.readyToSubmit;
  bool get showErrors => [
    NewAccountStatusCode.validationError,
    NewAccountStatusCode.userNameAlreadyExists,
  ].contains(status);
}
