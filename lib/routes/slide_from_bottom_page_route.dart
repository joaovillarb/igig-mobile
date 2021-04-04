import 'package:flutter/material.dart';

class SlideFromBottomPageRoute extends PageRouteBuilder {
  final Widget widget;

  SlideFromBottomPageRoute({this.widget}) : super (
    pageBuilder: (context, animation, secondaryAnimation) => widget,
    transitionsBuilder: (context, animation,  secondaryAnimation, child) {
      return SlideTransition(
        position: Tween<Offset>(
            begin: const Offset(0.0, 1.0),
            end: Offset.zero,
          ).animate(animation),
        child: SlideTransition(
          position: Tween<Offset>(
            begin: Offset.zero,
            end: const Offset(0.0,1.0),
        ).animate(secondaryAnimation),
        child: child,
        ),
      );
    },

  );
}