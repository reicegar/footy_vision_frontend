import 'package:flutter/material.dart';
import 'package:footy_vision_frontend/shared/constants.dart';

class CornerBorderPainter extends CustomPainter {
  final Color borderColor;
  final double borderWidth;
  final double borderLength;

  CornerBorderPainter({required this.borderColor, required this.borderWidth, required this.borderLength});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = borderColor
      ..strokeWidth = borderWidth
      ..style = PaintingStyle.stroke;

    Path path = Path()
      // corner top left
      ..moveTo(0, borderLength)
      ..lineTo(0, 0)
      ..lineTo(borderLength, 0)
      // corner top right
      ..moveTo(size.width - borderLength, 0)
      ..lineTo(size.width, 0)
      ..lineTo(size.width, borderLength)
      // corner bottom right
      ..moveTo(size.width, size.height - borderLength)
      ..lineTo(size.width, size.height)
      ..lineTo(size.width - borderLength, size.height)
      // corner bottom left
      ..moveTo(borderLength, size.height)
      ..lineTo(0, size.height)
      ..lineTo(0, size.height - borderLength);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class AnimatedLine extends StatelessWidget {
  final double progress;
  final double width;

  const AnimatedLine({super.key, required this.progress, this.width = double.infinity});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(size: Size(width, 2), painter: _LinePainter(progress));
  }
}

class _LinePainter extends CustomPainter {
  final double progress;
  _LinePainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = FColors.orange
      ..strokeWidth = 4.0
      ..strokeCap = StrokeCap.round;

    double centerX = size.width / 2;
    // Calculate expansion from 0 to half-width based on progress
    double halfWidth = (size.width / 2) * progress;

    canvas.drawLine(Offset(centerX - halfWidth, size.height / 2), Offset(centerX + halfWidth, size.height / 2), paint);
  }

  @override
  bool shouldRepaint(covariant _LinePainter oldDelegate) => oldDelegate.progress != progress;
}
