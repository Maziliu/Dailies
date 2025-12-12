import 'package:flutter/material.dart';

class SectionCard extends StatelessWidget {
  final Widget _child;
  final EdgeInsetsGeometry _padding;

  const SectionCard({
    super.key,
    required Widget child,
    EdgeInsetsGeometry padding = const EdgeInsetsGeometry.fromLTRB(
      12,
      0,
      12,
      0,
    ),
  }) : _child = child,
       _padding = padding;

  @override
  Widget build(BuildContext context) => Card(
    color: Theme.of(context).colorScheme.tertiary,
    child: Padding(
      padding: _padding,
      child: RepaintBoundary(child: _child),
    ),
  );
}
