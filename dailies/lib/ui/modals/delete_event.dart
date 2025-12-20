import 'package:flutter/material.dart';

enum EventDeleteOptions { CANCEL, DELETE_SERIES, DELETE_INSTANCE }

class DeleteEventModal extends StatelessWidget {
  final String title;
  final String message;

  const DeleteEventModal({
    super.key,
    required this.title,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(EventDeleteOptions.CANCEL),
          child: Text('Cancel'),
        ),
        TextButton(
          onPressed: () =>
              Navigator.of(context).pop(EventDeleteOptions.DELETE_SERIES),
          style: TextButton.styleFrom(foregroundColor: theme.colorScheme.error),
          child: Text('Delete Series'),
        ),
        TextButton(
          onPressed: () =>
              Navigator.of(context).pop(EventDeleteOptions.DELETE_INSTANCE),
          style: TextButton.styleFrom(foregroundColor: theme.colorScheme.error),
          child: Text('Delete'),
        ),
      ],
    );
  }
}
