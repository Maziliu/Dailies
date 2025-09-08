import 'package:dailies/ui/components/ui_formating.dart';
import 'package:dailies/ui/views/upload/file%20upload%20section/sub%20page/sections/configuration_section_view_model.dart';
import 'package:flutter/material.dart';

class ConfigurationSubmitSection extends StatelessWidget {
  final ConfigurationSectionViewModel _configurationSectionViewModel;

  const ConfigurationSubmitSection({super.key, required ConfigurationSectionViewModel configurationSectionViewModel})
    : _configurationSectionViewModel = configurationSectionViewModel;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      child: Padding(
        padding: UIFormating.smallPadding(),
        child: ElevatedButton(onPressed: () => Navigator.of(context).pop(_configurationSectionViewModel.configurations), child: const Text('Done')),
      ),
    );
  }
}
