import 'package:flutter/material.dart';

class DeleteConfirmationDialog extends StatelessWidget {
  final VoidCallback _onDelete;
  final String _itemName;

  const DeleteConfirmationDialog({super.key, required void Function() onDelete, required String itemName}) : _itemName = itemName, _onDelete = onDelete;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Delete Item?'),
      content: Text('Are you sure you want to delete "$_itemName"?'),
      actions: [
        TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text('Cancel')),
        TextButton(
          onPressed: () {
            _onDelete();
            Navigator.of(context).pop();
          },
          child: const Text('Delete'),
        ),
      ],
    );
  }
}
