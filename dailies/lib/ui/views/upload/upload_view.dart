import 'package:dailies/ui/views/upload/upload_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UploadView extends StatelessWidget {
  const UploadView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<UploadViewModel>(
      builder: (context, viewModel, child) {
        return const Center(child: Text('Upload'));
      },
    );
  }
}
