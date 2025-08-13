import 'package:dailies/ui/components/ui_formating.dart';
import 'package:flutter/material.dart';

class Section extends StatelessWidget {
  final List<Widget> _children;
  final EdgeInsetsGeometry? _padding;

  const Section({super.key, required List<Widget> children, EdgeInsetsGeometry? padding}) : _children = children, _padding = padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: _padding,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), border: Border.all(color: const Color.fromRGBO(158, 158, 158, 0.5))),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: _children),
    );
  }
}

class SectionHeader extends StatelessWidget {
  final Widget? _titleWidget;
  final String? _title;

  const SectionHeader({super.key, Widget? titleWidget, String? title}) : _titleWidget = titleWidget, _title = title;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Container(
      width: double.infinity,
      padding: UIFormating.smallPadding(),
      decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: Color.fromRGBO(158, 158, 158, 0.5)))),
      child:
          _titleWidget ??
          Container(
            padding: UIFormating.mediumPadding(),
            decoration: BoxDecoration(color: colorScheme.surface, borderRadius: const BorderRadius.vertical(top: Radius.circular(20))),
            child: Text(_title ?? '', style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700, color: colorScheme.onSurface)),
          ),
    );
  }
}

class SectionContent extends StatelessWidget {
  final Widget _child;
  final EdgeInsetsGeometry? _padding;

  const SectionContent({super.key, required Widget child, EdgeInsetsGeometry? padding}) : _padding = padding, _child = child;

  @override
  Widget build(BuildContext context) {
    return Padding(padding: _padding ?? EdgeInsets.zero, child: _child);
  }
}
