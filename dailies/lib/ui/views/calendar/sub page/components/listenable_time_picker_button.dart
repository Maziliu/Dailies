import 'package:flutter/material.dart';

class ListenableTimePickerButton extends StatelessWidget {
  final ValueNotifier<TimeOfDay> _listenable;

  const ListenableTimePickerButton({super.key, required ValueNotifier<TimeOfDay> listenable}) : _listenable = listenable;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: _listenable,
      builder: (context, _, __) {
        return OutlinedButton(
          onPressed: () async {
            final newTime = await showTimePicker(context: context, initialTime: _listenable.value);
            if (newTime != null) {
              _listenable.value = newTime;
            }
          },
          style: OutlinedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
          child: Text(_listenable.value.format(context), style: Theme.of(context).textTheme.bodyMedium),
        );
      },
    );
  }
}
