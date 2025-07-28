import 'package:flutter/material.dart';

/// A page route that fades and scales the page from the center, similar to
/// a popup transition. The page can be dismissed with a swipe-down gesture.
class PopUpPageRoute<T> extends PageRouteBuilder<T> {
  final WidgetBuilder builder;

  PopUpPageRoute({required this.builder})
      : super(
          pageBuilder: (context, animation, secondaryAnimation) =>
              builder(context),
          transitionDuration: const Duration(milliseconds: 400),
          reverseTransitionDuration: const Duration(milliseconds: 300),
        );

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    final curved = CurvedAnimation(
      parent: animation,
      curve: Curves.easeOut,
      reverseCurve: Curves.easeIn,
    );
    return FadeTransition(
      opacity: curved,
      child: ScaleTransition(
        scale: Tween<double>(begin: 0.9, end: 1).animate(curved),
        child: child,
      ),
    );
  }
}
