import 'package:dailies_v2/ui/theme/standards.dart';
import 'package:dailies_v2/ui/views/upload/file_upload.dart';
import 'package:dailies_v2/ui/views/upload/parsed_section.dart';
import 'package:flutter/material.dart';

class UploadView extends StatelessWidget {
  const UploadView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: UIFormating.mediumPadding(),
        child: Column(
          children: [
            Expanded(child: FileUploadSection()),
            const SizedBox(height: 8),
            Expanded(child: ParsedSection()),
          ],
        ),
      ),
    );
  }
}
