import 'dart:async';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:form_inputs/form_inputs.dart';
import 'package:image_picker/image_picker.dart';
import 'package:user_repository/user_repository.dart';

part 'new_account_event.dart';

part 'new_account_state.dart';

class NewAccountBloc extends Bloc<NewAccountEvent, NewAccountState> {
  NewAccountBloc(this._authenticationRepository)
      : super(const NewAccountState()) {
    on<NewAccountHandleChanged>(_onHandleChanged);
    on<NewAccountFullNameChanged>(_onFullNameChanged);
    on<NewAccountSubmitted>(_onSubmitted);
    on<ProfilePictureTapped>(_editPictureTappedToState);
    on<GalleryButtonTapped>(_galleryButtonTappedToState);
    on<CameraButtonTapped>(_cameraButtonTappedToState);
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
        status: !event.fullName.pure &&
                !state.handle.pure &&
                !state.profilePicture.pure
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
        status: !event.handle.pure &&
                !state.fullName.pure &&
                !state.profilePicture.pure
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
      await UserRepository().updateProfilePicture(state.profilePicture.value);

      emit(
        state.copyWith(status: NewAccountStatusCode.submissionSuccess),
      );
    } on Exception {
      emit(
        state.copyWith(status: NewAccountStatusCode.submissionFailure),
      );
    }
  }

  FutureOr<void> _editPictureTappedToState(
    ProfilePictureTapped event,
    Emitter<NewAccountState> emit,
  ) async {}

  Future<void> _galleryButtonTappedToState(
    GalleryButtonTapped event,
    Emitter<NewAccountState> emit,
  ) async {
    await _selectedImage(ImageSource.gallery, emit);
  }

  Future<void> _cameraButtonTappedToState(
    CameraButtonTapped event,
    Emitter<NewAccountState> emit,
  ) async {
    await _selectedImage(ImageSource.camera, emit);
  }

  Future<void> _selectedImage(
    ImageSource imageSource,
    Emitter<NewAccountState> emit,
  ) async {
    emit(state.copyWith(imagePickerStatus: ImagePickerStatus.loading));

    try {
      final selectedImage = await _getImage(imageSource);

      if (selectedImage.isEmpty) {
        emit(state.copyWith(imagePickerStatus: ImagePickerStatus.failure));
        return;
      }

      final profileImage = BasicInfo.dirty(selectedImage);
      emit(
        state.copyWith(
          imagePickerStatus: ImagePickerStatus.selected,
          profilePicture: profileImage,
          status:
              !profileImage.pure && !state.fullName.pure && !state.handle.pure
                  ? NewAccountStatusCode.readyToSubmit
                  : NewAccountStatusCode.notReady,
        ),
      );
      return;
    } catch (error) {
      emit(state.copyWith(imagePickerStatus: ImagePickerStatus.failure));
    }
  }

  Future<String> _getImage(ImageSource source) async {
    final image = await ImagePicker().pickImage(
      source: source,
      imageQuality: 50,
    );

    return image != null ? image.path : '';
  }

  bool _isValidForm() =>
      state.fullName.valid && state.handle.valid && state.profilePicture.valid;
}
