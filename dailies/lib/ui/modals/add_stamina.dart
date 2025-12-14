import 'package:dailies_v2/generated/assets.gen.dart';
import 'package:dailies_v2/models/stamina.dart';
import 'package:dailies_v2/ui/theme/standards.dart';
import 'package:dailies_v2/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class AddStaminaModal extends StatefulWidget {
  const AddStaminaModal({super.key});

  @override
  State<AddStaminaModal> createState() => _AddStaminaModalState();
}

class _AddStaminaModalState extends State<AddStaminaModal> {
  final _formKey = GlobalKey<FormBuilderState>();

  static const _GACHA_NAME_FIELD_TAG = 'gachaName';
  static const _MAX_STAMINA_FIELD_TAG = 'maxStamina';
  static const _RECHARGE_TIME_FIELD_TAG = 'rechargeTime';
  static const _CURRENT_STAMINA_FIELD_TAG = 'currentStamina';
  static const _ENERGY_TYPE_FIELD_TAG = 'energyType';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Material(
      color: theme.colorScheme.surface,
      child: SingleChildScrollView(
        child: Padding(
          padding: UIFormating.largePadding(),
          child: FormBuilder(
            key: _formKey,
            child: Column(
              children: [
                Center(
                  child: Text(
                    'Create New Gacha',
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                ),
                UIFormating.largeVerticalSpacing(),

                FormBuilderTextField(
                  name: _GACHA_NAME_FIELD_TAG,
                  decoration: const InputDecoration(labelText: 'Gacha Name'),
                  autofocus: true,
                  validator: (value) => (value == null || value.trim().isEmpty)
                      ? 'Required'
                      : null,
                ),

                UIFormating.smallVerticalSpacing(),

                FormBuilderTextField(
                  name: _MAX_STAMINA_FIELD_TAG,
                  decoration: const InputDecoration(labelText: 'Max Stamina'),
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  validator: (value) {
                    final parsed = int.tryParse(value ?? '');
                    if (parsed == null) return 'Required';
                    if (parsed <= 0) return 'Must be greater than zero';
                    return null;
                  },
                ),

                UIFormating.smallVerticalSpacing(),

                FormBuilderTextField(
                  name: _RECHARGE_TIME_FIELD_TAG,
                  decoration: const InputDecoration(
                    labelText: 'Recharge Time (seconds)',
                  ),
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  validator: (value) {
                    final parsed = int.tryParse(value ?? '');
                    if (parsed == null) return 'Required';
                    if (parsed <= 0) return 'Must be greater than zero';
                    return null;
                  },
                ),

                UIFormating.smallVerticalSpacing(),

                FormBuilderTextField(
                  name: _CURRENT_STAMINA_FIELD_TAG,
                  decoration: const InputDecoration(
                    labelText: 'Current Stamina',
                  ),
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                ),

                UIFormating.smallVerticalSpacing(),

                FormBuilderDropdown<AssetGenImage>(
                  name: _ENERGY_TYPE_FIELD_TAG,
                  decoration: const InputDecoration(labelText: 'Energy Type'),
                  validator: (value) => value == null ? 'Required' : null,
                  items: Assets.values
                      .where(
                        (asset) => !asset.path.toLowerCase().contains('icon'),
                      )
                      .map(
                        (asset) => DropdownMenuItem(
                          value: asset,
                          child: Row(
                            spacing: 12,
                            children: [
                              SizedBox(
                                width: 40,
                                height: 40,
                                child: asset.image(fit: BoxFit.contain),
                              ),
                              Text(formatAssetName(asset.path.split('/').last)),
                            ],
                          ),
                        ),
                      )
                      .toList(),
                ),

                UIFormating.mediumVerticalSpacing(),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: theme.colorScheme.primary,
                      foregroundColor: theme.colorScheme.onPrimary,
                    ),
                    onPressed: _submit,
                    child: const Text('Create'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _submit() {
    final state = _formKey.currentState;
    if (state == null || !state.validate()) return;

    final fields = state.fields;

    final String gachaName = fields[_GACHA_NAME_FIELD_TAG]!.value as String;
    final int maxStamina = int.parse(
      fields[_MAX_STAMINA_FIELD_TAG]!.value as String,
    );
    final int rechargeSeconds = int.parse(
      fields[_RECHARGE_TIME_FIELD_TAG]!.value as String,
    );
    final currentStamina =
        int.tryParse(fields[_CURRENT_STAMINA_FIELD_TAG]?.value ?? '') ?? 0;

    final imageName = (fields[_ENERGY_TYPE_FIELD_TAG]?.value as AssetGenImage?)
        ?.path
        .split('/')
        .last;

    final stamina = StaminaModel(
      gachaTitle: gachaName,
      maxStamina: maxStamina,
      rechargeTime: Duration(seconds: rechargeSeconds),
      imageName: imageName,
      timeOfLastReset: DateTime.now(),
      staminaOfLastestReset: currentStamina,
    );

    Navigator.of(context).pop<StaminaModel>(stamina);
  }
}
