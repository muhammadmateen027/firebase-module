import 'package:flutter/material.dart';

/// Bubbles type
enum ErrorBubbleType {
  /// to check either pin appears on left
  centerLeftPin,

  /// to check either pin appears on top left
  topLeftPin,
}

/// Customized clipper to create shape
class CustomErrorClipper extends CustomClipper<Path> {
  ///
  CustomErrorClipper({
    required this.errorBubbleType,
    this.radius = 5,
    this.offset = 10,
    this.nipSize = 10,
  });

  /// The radius of the icon
  final double radius;

  /// To adjust the offset
  final double offset;

  /// to adjust the pin or nipSize
  final double nipSize;

  /// To define the position of nip or pin
  final ErrorBubbleType errorBubbleType;

  @override
  Path getClip(Size size) {
    var path = Path();
    if (errorBubbleType == ErrorBubbleType.centerLeftPin) {
      path = _getCenterLeftPinPath(size);
    } else if (errorBubbleType == ErrorBubbleType.topLeftPin) {
      path = _getTopLeftPinPath(size);
    }

    return path;
  }

  Path _getTopLeftPinPath(Size size) {
    final path = Path()
      ..addRRect(
        RRect.fromLTRBR(
          nipSize,
          0,
          size.width,
          size.height,
          Radius.circular(radius),
        ),
      );

    final path2 = Path()
      ..moveTo(nipSize * 2, 0)
      ..lineTo(nipSize * 3, -nipSize)
      ..lineTo(nipSize * 4, 0);

    path.addPath(path2, Offset.zero);
    return path;
  }

  Path _getCenterLeftPinPath(Size size) {
    final path = Path()
      ..addRRect(
        RRect.fromLTRBR(
          nipSize,
          0,
          size.width,
          size.height,
          Radius.circular(radius),
        ),
      );

    final path2 = Path()
      ..lineTo(0, 2 * nipSize)
      ..lineTo(-nipSize, nipSize)
      ..lineTo(0, 0);

    path.addPath(path2, Offset(nipSize, size.height / 2.7));
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
