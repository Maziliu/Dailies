import 'package:dailies/generated/assets.gen.dart';
import 'package:dailies/ui/components/interface/animatable_widget.dart';
import 'package:dailies/ui/components/ui_formating.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class AddStaminaPopupCard extends StatefulWidget implements AnimatableWidget {
  final void Function(String, int, Duration, int, String?) _onSubmit;
  final String _heroTag;

  const AddStaminaPopupCard({super.key, required void Function(String, int, Duration, int, String?) onSubmit, required String heroTag})
    : _onSubmit = onSubmit,
      _heroTag = heroTag;

  @override
  State<AddStaminaPopupCard> createState() => _AddStaminaPopupCardState();

  @override
  String get heroTag => _heroTag;
}

class _AddStaminaPopupCardState extends State<AddStaminaPopupCard> {
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
  final String _gachaNameFieldTag = 'gachaName',
      _maxStaminaFieldTag = 'maxStamina',
      _rechargeTimeFieldTag = 'rechargeTime',
      _currentStamina = 'currentStamina',
      _energyType = 'energyType';

  String _formatAssetName(String filename) {
    final nameWithoutExtension = filename.split('.').first;

    final noUnderscoresOrNonAlphaNumeric = nameWithoutExtension.replaceAll(RegExp(r'[^a-zA-Z0-9]+'), ' ');

    final words = noUnderscoresOrNonAlphaNumeric.split(' ').where((word) => word.isNotEmpty);

    final capitalizedWords = words.map((word) => word[0].toUpperCase() + word.substring(1).toLowerCase());

    return capitalizedWords.join(' ');
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme;

    return SingleChildScrollView(
      child: Padding(
        padding: UIFormating.largePadding(),
        child: FormBuilder(
          key: _formKey,
          child: Column(
            children: [
              Center(
                child: Text(
                  'Create New Gacha Widget',
                  style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold, color: colorScheme.onSurface),
                ),
              ),
              UIFormating.largeVerticalSpacing(),
              FormBuilderTextField(
                name: _gachaNameFieldTag,
                decoration: const InputDecoration(labelText: 'Gacha Name'),
                validator: (value) => (value == null) ? "Required" : null,
              ),

              UIFormating.smallVerticalSpacing(),
              FormBuilderTextField(
                name: _maxStaminaFieldTag,
                decoration: const InputDecoration(labelText: 'Max Stamina'),
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                validator: (value) => (value == null) ? "Required" : null,
              ),
              UIFormating.smallVerticalSpacing(),
              FormBuilderTextField(
                name: _rechargeTimeFieldTag,
                decoration: const InputDecoration(labelText: 'Recharge Time In Seconds'),
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                validator:
                    (value) =>
                        (value == null)
                            ? "Required"
                            : (int.parse(value) <= 0)
                            ? "Must be non zero"
                            : null,
              ),
              UIFormating.smallVerticalSpacing(),
              FormBuilderTextField(
                name: _currentStamina,
                decoration: const InputDecoration(labelText: 'Current Stamina'),
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              ),
              UIFormating.smallVerticalSpacing(),
              FormBuilderDropdown<AssetGenImage>(
                name: _energyType,
                items:
                    Assets.values
                        .map(
                          (asset) => DropdownMenuItem<AssetGenImage>(
                            value: asset,
                            child: Row(
                              children: [
                                SizedBox(width: 40, height: 40, child: asset.image(fit: BoxFit.contain)),
                                const SizedBox(width: 10),
                                Text(_formatAssetName(asset.path.split('/').last)),
                              ],
                            ),
                          ),
                        )
                        .toList(),
                decoration: const InputDecoration(labelText: 'Energy Type'),
                validator: (value) => (value == null) ? 'Required' : null,
              ),
              UIFormating.mediumVerticalSpacing(),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    Map<String, dynamic>? fields = _formKey.currentState?.fields;

                    final String gachaName = fields?[_gachaNameFieldTag].value;
                    final int rechargeTimeInSeconds = int.parse(fields?[_rechargeTimeFieldTag].value),
                        maxStamina = int.parse(fields?[_maxStaminaFieldTag].value);
                    final int currentStamina = int.parse(fields?[_currentStamina].value ?? '0');

                    final String? imageName = (fields?[_energyType].value as AssetGenImage?)?.path.split('/').last;

                    widget._onSubmit(gachaName, maxStamina, Duration(seconds: rechargeTimeInSeconds), currentStamina, imageName);

                    Navigator.of(context).pop();
                  }
                },
                style: ElevatedButton.styleFrom(backgroundColor: colorScheme.primary, foregroundColor: colorScheme.onPrimary),
                child: const Text('Create Widget'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
