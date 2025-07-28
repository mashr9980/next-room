import 'dart:math';
import 'package:flutter/material.dart';

class IOSStyleSpinner extends StatefulWidget {
  final double size;
  final Color activeColor;
  final Color inactiveColor;
  final Duration duration;

  const IOSStyleSpinner({
    super.key,
    this.size = 50.0,
    this.activeColor = Colors.blue,
    this.inactiveColor = Colors.white,
    this.duration = const Duration(milliseconds: 1000),
  });

  @override
  State<IOSStyleSpinner> createState() => _IOSStyleSpinnerState();
}

class _IOSStyleSpinnerState extends State<IOSStyleSpinner>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: widget.duration, vsync: this)
      ..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.size,
      height: widget.size,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return CustomPaint(
            painter: _SpinnerPainter(
              index: (_controller.value * 8).floor(),
              activeColor: widget.activeColor,
              inactiveColor: widget.inactiveColor,
            ),
          );
        },
      ),
    );
  }
}

class _SpinnerPainter extends CustomPainter {
  final int index;
  final Color activeColor;
  final Color inactiveColor;

  _SpinnerPainter({
    required this.index,
    required this.activeColor,
    required this.inactiveColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    const int segmentCount = 8;
    final Paint paint =
        Paint()
          ..strokeWidth = 3.5
          ..strokeCap = StrokeCap.round;

    final radius = size.width / 2;
    final center = Offset(radius, radius);

    for (int i = 0; i < segmentCount; i++) {
      final angle = 2 * pi * (i / segmentCount);
      final start = Offset(
        center.dx + radius * 0.6 * cos(angle),
        center.dy + radius * 0.6 * sin(angle),
      );
      final end = Offset(
        center.dx + radius * 0.9 * cos(angle),
        center.dy + radius * 0.9 * sin(angle),
      );

      paint.color = i == index ? activeColor : inactiveColor;
      canvas.drawLine(start, end, paint);
    }
  }

  @override
  bool shouldRepaint(covariant _SpinnerPainter oldDelegate) =>
      oldDelegate.index != index;
}
