import 'package:flutter/material.dart';

class ConfirmationModal extends StatelessWidget {
  final String title;
  final String message;
  final String cancelText;
  final String confirmText;
  final bool destructive;

  const ConfirmationModal({
    super.key,
    required this.title,
    required this.message,
    this.cancelText = 'Cancel',
    this.confirmText = 'Confirm',
    this.destructive = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: Text(cancelText),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(true),
          style: TextButton.styleFrom(
            foregroundColor: destructive ? theme.colorScheme.error : null,
          ),
          child: Text(confirmText),
        ),
      ],
    );
  }
}
