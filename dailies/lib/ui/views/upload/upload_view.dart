import 'package:dailies/ui/components/ui_formating.dart';
import 'package:dailies/ui/views/upload/file%20upload%20section/file_upload_section.dart';
import 'package:dailies/ui/views/upload/parsed%20events%20section/parsed_events_section.dart';
import 'package:dailies/ui/views/upload/upload_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UploadView extends StatelessWidget {
  const UploadView({super.key});

  @override
  Widget build(BuildContext context) {
    UploadViewModel uploadViewModel = context.watch<UploadViewModel>();

    return Padding(
      padding: UIFormating.largePadding(),
      child: Column(
        children: [
          FileUploadSection(fileUploadViewModel: uploadViewModel.fileUploadViewModel),
          ParsedEventsSection(parsedEventsViewModel: uploadViewModel.parsedEventsViewModel),
        ],
      ),
    );
  }
}
