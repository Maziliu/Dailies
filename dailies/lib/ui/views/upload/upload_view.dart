import 'package:dailies_v2/ui/theme/standards.dart';
import 'package:dailies_v2/ui/views/upload/file_upload.dart';
import 'package:dailies_v2/ui/views/upload/parsed_section.dart';
import 'package:flutter/material.dart';

class UploadView extends StatelessWidget {
  const UploadView({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height / 2;

    return Scaffold(
      body: SingleChildScrollView(
        padding: UIFormating.mediumPadding(),
        child: Column(
          children: [
            SizedBox(height: height, child: const FileUploadSection()),
            const SizedBox(height: 8),
            SizedBox(height: height, child: const ParsedSection()),
          ],
        ),
      ),
    );
  }
}
