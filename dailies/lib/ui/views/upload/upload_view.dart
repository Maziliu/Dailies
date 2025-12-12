import 'package:dailies/ui/components/section_card.dart';
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
    final UploadViewModel uploadViewModel = context.watch<UploadViewModel>();
    return Scaffold(
      body: SingleChildScrollView(
        padding: UIFormating.mediumPadding(),
        child: Column(
          children: [
            SectionCard(
              child: FileUploadSection(
                fileUploadViewModel: uploadViewModel.fileUploadViewModel,
                configurationSectionViewModel:
                    uploadViewModel.configurationSectionViewModel,
              ),
            ),
            UIFormating.mediumVerticalSpacing(),
            SectionCard(
              child: ParsedEventsSection(
                parsedEventsViewModel: uploadViewModel.parsedEventsViewModel,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
