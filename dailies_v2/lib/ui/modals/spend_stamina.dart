import 'package:dailies_v2/ui/theme/standards.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class SpendStaminaModal extends StatefulWidget {
  const SpendStaminaModal({super.key});

  @override
  State<SpendStaminaModal> createState() => _SpendStaminaModalState();
}

class _SpendStaminaModalState extends State<SpendStaminaModal> {
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
  final String _setStaminaToTag = 'burnStaminaToTag';

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Material(
      color: theme.colorScheme.surface,
      child: SingleChildScrollView(
        child: Padding(
          padding: UIFormating.largePadding(),
          child: FormBuilder(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center(
                  child: Text(
                    'Set Remaining Stamina',
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                ),
                UIFormating.largeVerticalSpacing(),
                FormBuilderTextField(
                  name: _setStaminaToTag,
                  decoration: const InputDecoration(
                    labelText: 'Remaining Stamina',
                  ),
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  validator: (value) => (value == null) ? 'Required' : null,
                ),
                UIFormating.mediumVerticalSpacing(),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      final Map<String, dynamic>? fields =
                          _formKey.currentState?.fields;

                      final int? remainingStamina = int.tryParse(
                        fields?[_setStaminaToTag].value,
                      );

                      Navigator.pop(context, remainingStamina);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: theme.colorScheme.primary,
                    foregroundColor: theme.colorScheme.onPrimary,
                  ),
                  child: const Text('Set'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
