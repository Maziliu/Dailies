import 'package:dailies/common/utils/build_context_extensions.dart';
import 'package:dailies/ui/components/ui_formating.dart';
import 'package:flutter/material.dart';

class ListenableRowToggle extends StatelessWidget {
  final ValueNotifier<bool> _toggleListenable;
  final Widget? _toggledWidget;
  final String _labelText;

  const ListenableRowToggle({
    super.key,
    required ValueNotifier<bool> toggleListenable,
    Widget? toggledWidget,
    required String labelText,
  }) : _toggleListenable = toggleListenable,
       _toggledWidget = toggledWidget,
       _labelText = labelText;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: _toggleListenable,
      builder: (context, toggleState, _) {
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _labelText,
                  style: context.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Switch(
                  value: toggleState,
                  onChanged:
                      (bool newState) =>
                          _toggleSwitch(newState, _toggleListenable),
                ),
              ],
            ),

            if (_toggledWidget != null)
              Visibility(
                visible: toggleState,
                child: Column(
                  children: [
                    UIFormating.smallVerticalSpacing(),
                    _toggledWidget,
                  ],
                ),
              ),
          ],
        );
      },
    );
  }

  void _toggleSwitch(bool newState, ValueNotifier<bool> toggleListenable) {
    toggleListenable.value = newState;
  }
}
