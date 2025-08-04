import 'package:flutter/material.dart';

class HeroDialogRoute<T> extends PageRoute<T> {
  final WidgetBuilder _builder;

  HeroDialogRoute({super.settings, required WidgetBuilder builder, bool barrierDismissible = true})
    : _builder = builder,
      _barrierDismissible = barrierDismissible;

  final bool _barrierDismissible;

  @override
  bool get barrierDismissible => _barrierDismissible;

  @override
  Color get barrierColor => Colors.black54;

  @override
  String get barrierLabel => "Dialog";

  @override
  Widget buildPage(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
    return _builder(context);
  }

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
    return FadeTransition(opacity: CurvedAnimation(parent: animation, curve: Curves.easeOut), child: child);
  }

  @override
  bool get maintainState => true;

  @override
  Duration get transitionDuration => const Duration(milliseconds: 300);

  @override
  bool get opaque => false;
}
