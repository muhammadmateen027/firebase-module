import 'package:flutter/material.dart';

/// Circle image view
class CircleImageView extends StatelessWidget {
  /// CircleImageView concrete method
  const CircleImageView({
    required this.imageProvider,
    Key? key,
  }) : super(key: key);

  /// provide image to show in a container
  final ImageProvider imageProvider;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 140,
        height: 140,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
            image: imageProvider,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
