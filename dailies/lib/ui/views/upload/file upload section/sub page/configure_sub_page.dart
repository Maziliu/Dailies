import 'package:dailies/common/utils/build_context_extensions.dart';
import 'package:dailies/ui/components/ui_formating.dart';
import 'package:dailies/ui/views/upload/file%20upload%20section/sub%20page/sections/configuration_section.dart';
import 'package:dailies/ui/views/upload/file%20upload%20section/sub%20page/sections/configuration_section_view_model.dart';
import 'package:dailies/ui/views/upload/file%20upload%20section/sub%20page/sections/configuration_submit_section.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class ConfigureSubPage extends StatelessWidget {
  final ConfigurationSectionViewModel _viewModel;
  final List<PlatformFile> _files;

  const ConfigureSubPage({super.key, required ConfigurationSectionViewModel viewModel, required List<PlatformFile> files})
    : _viewModel = viewModel,
      _files = files;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Configure', style: context.textTheme.headlineLarge), centerTitle: true),
      body: SingleChildScrollView(
        child: Padding(
          padding: UIFormating.mediumPadding(),
          child: Column(
            children: [
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _files.length,
                itemBuilder: (context, index) => ConfigurationSection(file: _files[index], onChanged: _viewModel.updateConfigurations),
                separatorBuilder: (_, _) => UIFormating.smallVerticalSpacing(),
              ),

              ConfigurationSubmitSection(configurationSectionViewModel: _viewModel),
            ],
          ),
        ),
      ),
    );
  }
}
