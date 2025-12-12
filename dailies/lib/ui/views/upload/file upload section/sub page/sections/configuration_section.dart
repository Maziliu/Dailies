import 'package:dailies/common/utils/build_context_extensions.dart';
import 'package:dailies/common/utils/ui_helpers.dart';
import 'package:dailies/ui/components/section_card.dart';
import 'package:dailies/ui/components/ui_formating.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

final String INSTRUCTIONS_FIELD_TAG = 'instructionsFieldTag';
final String CONDENSE_FIELD_TAG = 'rawDumpFieldTag';

class ConfigurationSection extends StatelessWidget {
  final GlobalKey<FormBuilderState> _formKey = GlobalKey();
  final PlatformFile _file;
  final void Function(PlatformFile, Map<String, dynamic>) _onChanged;

  ConfigurationSection({
    super.key,
    required PlatformFile file,
    required void Function(PlatformFile, Map<String, dynamic>) onChanged,
  }) : _file = file,
       _onChanged = onChanged;

  void _handleChange() {
    final formState = _formKey.currentState;

    if (formState != null) {
      formState.save();
      _onChanged(_file, formState.value);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SectionCard(
      child: Padding(
        padding: UIFormating.smallPadding(),
        child: Column(
          children: [
            FormBuilder(
              key: _formKey,
              onChanged: _handleChange,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text('File: ', style: context.textTheme.headlineMedium),
                      Flexible(
                        child: Text(
                          _file.name.split('.')[0],
                          style: context.textTheme.headlineMedium?.copyWith(
                            color: Colors.grey,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  UIFormating.smallVerticalSpacing(),
                  Row(
                    children: [
                      Text('Size: ', style: context.textTheme.headlineMedium),
                      Flexible(
                        child: Text(
                          formatFileSize(_file.size),
                          style: context.textTheme.headlineMedium?.copyWith(
                            color: Colors.grey,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  UIFormating.smallVerticalSpacing(),
                  Row(
                    children: [
                      Text(
                        'Extension: ',
                        style: context.textTheme.headlineMedium,
                      ),
                      Flexible(
                        child: Text(
                          _file.extension ?? 'Unknown',
                          style: context.textTheme.headlineMedium?.copyWith(
                            color: Colors.grey,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  UIFormating.smallVerticalSpacing(),
                  Text(
                    'Additional Instructions',
                    style: context.textTheme.headlineMedium,
                  ),
                  UIFormating.smallVerticalSpacing(),
                  FormBuilderTextField(
                    name: INSTRUCTIONS_FIELD_TAG,
                    maxLines: 5,
                    decoration: const InputDecoration(
                      hintText: 'eg: Course: PHYS 369',
                    ),
                  ),
                  UIFormating.smallVerticalSpacing(),
                  FormBuilderCheckbox(
                    name: CONDENSE_FIELD_TAG,
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Condense',
                          style: context.textTheme.headlineMedium,
                        ),
                        const Tooltip(
                          message:
                              'Checking this off will enable text chunking. This will extract only the relavent text but results in less accuracy. Large text files may take a long time without this enabled',
                          child: Icon(
                            Icons.help_outline,
                            size: 25,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
