import 'package:dailies/ui/components/interface/animatable_widget.dart';
import 'package:dailies/ui/components/ui_formating.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class SetStaminaPopupCard extends StatefulWidget implements AnimatableWidget {
  final String _heroTag;

  const SetStaminaPopupCard({super.key, required String heroTag}) : _heroTag = heroTag;

  @override
  State<SetStaminaPopupCard> createState() => _SetStaminaPopupCardState();

  @override
  String get heroTag => _heroTag;
}

class _SetStaminaPopupCardState extends State<SetStaminaPopupCard> {
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
  final String _setStaminaToTag = 'burnStaminaToTag';

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
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: Text('Set Remaining Stamina', style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold, color: colorScheme.onSurface)),
              ),
              UIFormating.largeVerticalSpacing(),
              FormBuilderTextField(
                name: _setStaminaToTag,
                decoration: const InputDecoration(labelText: 'Remaining Stamina'),
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                validator: (value) => (value == null) ? "Required" : null,
              ),
              UIFormating.mediumVerticalSpacing(),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    Map<String, dynamic>? fields = _formKey.currentState?.fields;

                    int remainingStamina = int.parse(fields?[_setStaminaToTag].value ?? '0');

                    Navigator.pop(context, remainingStamina);
                  }
                },
                style: ElevatedButton.styleFrom(backgroundColor: colorScheme.primary, foregroundColor: colorScheme.onPrimary),
                child: const Text('Set'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
