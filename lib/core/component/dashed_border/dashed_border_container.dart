// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class DashedBorderContainer extends StatelessWidget {
  final Widget child;
  final Color? dashedBorderColor;
  const DashedBorderContainer({
    super.key,
    required this.child,
    this.dashedBorderColor,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: DashedBorderPainter(dashedBorderColor: dashedBorderColor),
      child: child,
    );
  }
}

class DashedBorderPainter extends CustomPainter {
  final Color? dashedBorderColor;
  final double strokeWidth;
  final double dashWidth;
  final double gapWidth;

  DashedBorderPainter({
    this.dashedBorderColor = Colors.blue,
    this.strokeWidth = 1.0,
    this.dashWidth = 9.0,
    this.gapWidth = 5.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = dashedBorderColor!
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    void drawDashedLine(Offset start, Offset end) {
      double totalLength = (end - start).distance;
      double currentLength = 0.0;
      bool draw = true;

      while (currentLength < totalLength) {
        double nextSegment = draw ? dashWidth : gapWidth;
        if (currentLength + nextSegment > totalLength) {
          nextSegment = totalLength - currentLength;
        }

        if (draw) {
          canvas.drawLine(
            start + (end - start) * (currentLength / totalLength),
            start +
                (end - start) * ((currentLength + nextSegment) / totalLength),
            paint,
          );
        }

        currentLength += nextSegment;
        draw = !draw;
      }
    }

    drawDashedLine(const Offset(0, 0), Offset(size.width, 0)); // Top
    drawDashedLine(
        Offset(size.width, 0), Offset(size.width, size.height)); // Right
    drawDashedLine(
        Offset(0, size.height), Offset(size.width, size.height)); // Bottom
    drawDashedLine(const Offset(0, 0), Offset(0, size.height)); // Left
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
