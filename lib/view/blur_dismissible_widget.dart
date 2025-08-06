import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BlurDismissibleWidget extends StatefulWidget {
  final Widget child;
  final VoidCallback? onDismiss;
  final double dismissThreshold;
  final bool enableDismiss;

  const BlurDismissibleWidget({
    super.key,
    required this.child,
    this.onDismiss,
    this.dismissThreshold = 80.0,
    this.enableDismiss = true,
  });

  @override
  State<BlurDismissibleWidget> createState() => _BlurDismissibleWidgetState();
}

class _BlurDismissibleWidgetState extends State<BlurDismissibleWidget>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  late Animation<double> _blurAnimation;

  double _dragDistance = 0.0;
  bool _isDragging = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 250),
      vsync: this,
    );

    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );

    _blurAnimation = Tween<double>(begin: 0.0, end: 6.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _handlePanUpdate(DragUpdateDetails details) {
    if (!widget.enableDismiss) return;

    if (details.delta.dy > 0) {
      setState(() {
        _dragDistance += details.delta.dy;
        _isDragging = true;
      });

      double progress = (_dragDistance / widget.dismissThreshold).clamp(0.0, 1.0);
      _animationController.value = progress;
    }
  }

  void _handlePanEnd(DragEndDetails details) {
    if (!widget.enableDismiss) return;

    if (_dragDistance > widget.dismissThreshold) {
      _animationController.forward().then((_) {
        widget.onDismiss?.call();
        Get.back();
      });
    } else {
      _animationController.reverse().then((_) {
        setState(() {
          _dragDistance = 0.0;
          _isDragging = false;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Stack(
          children: [
            if (_isDragging || _animationController.value > 0)
              Positioned.fill(
                child: BackdropFilter(
                  filter: ImageFilter.blur(
                    sigmaX: _blurAnimation.value,
                    sigmaY: _blurAnimation.value,
                  ),
                  child: Container(
                    color: Colors.black.withOpacity(0.5 * _animation.value),
                  ),
                ),
              ),
            Transform.translate(
              offset: Offset(0, _dragDistance),
              child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                onPanUpdate: _handlePanUpdate,
                onPanEnd: _handlePanEnd,
                child: widget.child,
              ),
            ),
          ],
        );
      },
    );
  }
}

class BlurDismissibleBottomSheet extends StatefulWidget {
  final Widget child;
  final VoidCallback? onDismiss;
  final double dismissThreshold;
  final bool enableDismiss;

  const BlurDismissibleBottomSheet({
    super.key,
    required this.child,
    this.onDismiss,
    this.dismissThreshold = 80.0,
    this.enableDismiss = true,
  });

  @override
  State<BlurDismissibleBottomSheet> createState() => _BlurDismissibleBottomSheetState();
}

class _BlurDismissibleBottomSheetState extends State<BlurDismissibleBottomSheet>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  late Animation<double> _blurAnimation;

  double _dragDistance = 0.0;
  bool _isDragging = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 250),
      vsync: this,
    );

    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );

    _blurAnimation = Tween<double>(begin: 0.0, end: 6.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _handlePanUpdate(DragUpdateDetails details) {
    if (!widget.enableDismiss) return;

    if (details.delta.dy > 0) {
      setState(() {
        _dragDistance += details.delta.dy;
        _isDragging = true;
      });

      double progress = (_dragDistance / widget.dismissThreshold).clamp(0.0, 1.0);
      _animationController.value = progress;
    }
  }

  void _handlePanEnd(DragEndDetails details) {
    if (!widget.enableDismiss) return;

    if (_dragDistance > widget.dismissThreshold) {
      _animationController.forward().then((_) {
        widget.onDismiss?.call();
        Get.back();
      });
    } else {
      _animationController.reverse().then((_) {
        setState(() {
          _dragDistance = 0.0;
          _isDragging = false;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Stack(
          children: [
            if (_isDragging || _animationController.value > 0)
              Positioned.fill(
                child: BackdropFilter(
                  filter: ImageFilter.blur(
                    sigmaX: _blurAnimation.value,
                    sigmaY: _blurAnimation.value,
                  ),
                  child: Container(
                    color: Colors.black.withOpacity(0.5 * _animation.value),
                  ),
                ),
              ),
            Transform.translate(
              offset: Offset(0, _dragDistance),
              child: GestureDetector(
                onPanUpdate: _handlePanUpdate,
                onPanEnd: _handlePanEnd,
                child: widget.child,
              ),
            ),
          ],
        );
      },
    );
  }
}