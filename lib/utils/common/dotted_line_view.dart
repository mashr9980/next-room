import 'dart:ui';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: DashedBorderContainer(
            color: Colors.blue,
            strokeWidth: 2,
            dashWidth: 8,
            dashSpace: 4,
            radius: 12,
            child: Container(
              padding: EdgeInsets.all(20),
              child: Text('Content with Dashed Border'),
            ),
          ),
        ),
      ),
    );
  }
}

class DashedBorderContainer extends StatelessWidget {
  final Widget child;
  final Color color;
  final double strokeWidth;
  final double dashWidth;
  final double dashSpace;
  final double radius;

  const DashedBorderContainer({
    Key? key,
    required this.child,
    this.color = Colors.black,
    this.strokeWidth = 1.0,
    this.dashWidth = 5.0,
    this.dashSpace = 3.0,
    this.radius = 0.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: DashedRectPainter(
        color: color,
        strokeWidth: strokeWidth,
        dashWidth: dashWidth,
        dashSpace: dashSpace,
        radius: radius,
      ),
      child: Padding(
        padding: EdgeInsets.all(strokeWidth),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(radius),
          child: child,
        ),
      ),
    );
  }
}

class DashedRectPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final double dashWidth;
  final double dashSpace;
  final double radius;

  DashedRectPainter({
    this.color = Colors.black,
    this.strokeWidth = 1.0,
    this.dashWidth = 5.0,
    this.dashSpace = 3.0,
    this.radius = 0.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final rect = Rect.fromLTWH(
      strokeWidth / 2,
      strokeWidth / 2,
      size.width - strokeWidth,
      size.height - strokeWidth,
    );
    final rrect = RRect.fromRectAndRadius(rect, Radius.circular(radius));

    final path = Path()..addRRect(rrect);

    final dashPath = Path();
    final dashLength = dashWidth;
    final dashSpaceLength = dashSpace;
    final metrics = path.computeMetrics();
    final totalLength = metrics.fold(0.0, (prev, metric) => prev + metric.length);
    var currentLength = 0.0;

    while (currentLength < totalLength) {
      final isDash = currentLength % (dashLength + dashSpaceLength) < dashLength;
      if (isDash) {
        final pos = _getPosAtLength(path, currentLength);
        if (pos != null) {
          dashPath.moveTo(pos.position.dx, pos.position.dy);
          final endPos = _getPosAtLength(path, currentLength + 1);
          if (endPos != null) {
            dashPath.lineTo(endPos.position.dx, endPos.position.dy);
          }
        }
      }
      currentLength += 1;
    }

    canvas.drawPath(dashPath, paint);
  }

  Tangent? _getPosAtLength(Path path, double length) {
    for (final metric in path.computeMetrics()) {
      if (length < metric.length) {
        return metric.getTangentForOffset(length);
      }
      length -= metric.length;
    }
    return null;
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}