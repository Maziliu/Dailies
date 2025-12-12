import 'package:dailies_v2/ui/theme/standards.dart';
import 'package:dailies_v2/ui/views/upload/file_upload.dart';
import 'package:flutter/material.dart';

class UploadView extends StatelessWidget {
  const UploadView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: UIFormating.mediumPadding(),
        child: Column(spacing: 4, children: [FileUploadSection()]),
      ),
    );
  }
}
