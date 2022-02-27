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

enum ImagePickerStatus {
  init,
  selected,
  notReady,
  loading,
  failure,
}

class NewAccountState extends Equatable {
  const NewAccountState({
    this.status = NewAccountStatusCode.notReady,
    this.imagePickerStatus = ImagePickerStatus.init,
    this.handle = const Handle.pure(),
    this.fullName = const FullName.pure(),
    this.profilePicture = const BasicInfo.pure(),
  });

  final NewAccountStatusCode status;
  final Handle handle;
  final FullName fullName;
  final ImagePickerStatus imagePickerStatus;
  final BasicInfo profilePicture;

  NewAccountState copyWith({
    NewAccountStatusCode? status,
    ImagePickerStatus? imagePickerStatus,
    Handle? handle,
    FullName? fullName,
    BasicInfo? profilePicture,
    bool? showErrors,
  }) {
    return NewAccountState(
      status: status ?? this.status,
      imagePickerStatus: imagePickerStatus ?? this.imagePickerStatus,
      profilePicture: profilePicture ?? this.profilePicture,
      handle: handle ?? this.handle,
      fullName: fullName ?? this.fullName,
    );
  }

  @override
  List<Object?> get props => [
    handle,
    status,
    fullName,
    imagePickerStatus,
    profilePicture,
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
