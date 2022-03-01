import 'dart:io';

import 'package:app_ui/app_ui.dart';
import 'package:assignment/pages/authentication/authentication.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileImageView extends StatelessWidget {
  const ProfileImageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: AppSpacing.lg),
      child: Stack(
        children: const [
          _ImageView(),
          _ImageSelector(),
        ],
      ),
    );
  }
}

class _ImageView extends StatelessWidget {
  const _ImageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = context.select((NewAccountBloc bloc) => bloc.state);

    return CircleImageView(imageProvider: _getImage(state));
  }

  ImageProvider _getImage(NewAccountState state) {
    if (state.imagePickerStatus == ImagePickerStatus.selected) {
      return FileImage(File(state.profilePicture.value));
    }

    return const ExactAssetImage('assets/images/profile.png');
  }
}

class _ImageSelector extends StatelessWidget {
  const _ImageSelector({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 90),
          child: IconButton(
            onPressed: () {
              context.read<NewAccountBloc>().add(CameraButtonTapped());
            },
            icon: CircleAvatar(
              backgroundColor: Theme.of(context).primaryColor,
              radius: 30,
              child: const Icon(
                Icons.camera_alt,
                size: 18,
                color: CustomColors.white,
              ),
            ),
          ),
        ),
        // SizedBox(width: 20),
        Padding(
          padding: const EdgeInsets.only(top: 90),
          child: IconButton(
            onPressed: () {
              context.read<NewAccountBloc>().add(GalleryButtonTapped());
            },
            icon: CircleAvatar(
              backgroundColor: Theme.of(context).primaryColor,
              radius: 30,
              child: const Icon(
                Icons.insert_photo,
                size: 18,
                color: CustomColors.white,
              ),
            ),
          ),
        )
      ],
    );
  }
}
