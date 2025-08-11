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
  final String _gachaNameFieldTag = 'gachaName', _maxStaminaFieldTag = 'maxStamina', _rechargeTimeFieldTag = 'rechargeTime', _currentStamina = 'currentStamina';

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
                validator: (value) => (value == null) ? "Required" : null,
              ),
              UIFormating.smallVerticalSpacing(),
              FormBuilderTextField(
                name: _currentStamina,
                decoration: const InputDecoration(labelText: 'Current Stamina'),
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
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

                    widget._onSubmit(gachaName, maxStamina, Duration(seconds: rechargeTimeInSeconds), currentStamina, '');

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
