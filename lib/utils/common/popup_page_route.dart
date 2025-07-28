import 'package:flutter/material.dart';

class PopUpPageRoute<T> extends PageRouteBuilder<T> {
  final WidgetBuilder builder;
  PopUpPageRoute({required this.builder})
      : super(
          pageBuilder: (context, animation, secondaryAnimation) => builder(context),
          transitionDuration: const Duration(milliseconds: 400),
          reverseTransitionDuration: const Duration(milliseconds: 300),
        );

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    final curved = CurvedAnimation(parent: animation, curve: Curves.easeOut);
    return FadeTransition(
      opacity: curved,
      child: ScaleTransition(
        scale: Tween<double>(begin: 0.8, end: 1.0).animate(curved),
        alignment: Alignment.center,
        child: child,
      ),
    );
  }
}
