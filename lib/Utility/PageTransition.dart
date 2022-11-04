import 'package:flutter/material.dart';

class LeftTransitions extends PageRouteBuilder {
  final Widget child;
  LeftTransitions({required this.child})
      : super(
            transitionDuration: Duration(milliseconds: 200),
            pageBuilder: (context, animation, secondaryAnimation) => child);

  @override
  Widget buildTransitions(
          BuildContext context,
          Animation<double> animation,
          // TODO: implement buildTransitions
          Animation<double> secondaryAnimation,
          Widget child) =>
      SlideTransition(
        position: Tween(begin: Offset(1.0, 0.0), end: Offset(0.0, 0.0))
            .animate(animation),
        child: child,
      );
}

class RightTransitions extends PageRouteBuilder {
  final Widget child;
  RightTransitions({required this.child})
      : super(
            transitionDuration: Duration(milliseconds: 200),
            pageBuilder: (context, animation, secondaryAnimation) => child);

  @override
  Widget buildTransitions(
          BuildContext context,
          Animation<double> animation,
          // TODO: implement buildTransitions
          Animation<double> secondaryAnimation,
          Widget child) =>
      SlideTransition(
        position: Tween(begin: Offset(-1.0, 0.0), end: Offset(0.0, 0.0))
            .animate(animation),
        child: child,
      );
}
