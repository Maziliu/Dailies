import 'package:dailies/ui/components/ui_formating.dart';
import 'package:flutter/material.dart';

class SectionCard extends StatelessWidget {
  final Widget _child;
  final EdgeInsetsGeometry _padding;

  const SectionCard({super.key, required Widget child, EdgeInsetsGeometry padding = const EdgeInsetsGeometry.all(8)}) : _child = child, _padding = padding;

  @override
  Widget build(BuildContext context) => Card(child: Padding(padding: _padding, child: _child));
}
