import 'package:dailies/ui/views/common_widgets/hero_dialog_route.dart';
import 'package:flutter/material.dart';

const String _addEventHeroTag = 'Add event';

class _AddEventPopupCard extends StatelessWidget {
  const _AddEventPopupCard();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Hero(
          tag: _addEventHeroTag,
          child: Material(
            color: colorScheme.surface,
            elevation: 8,
            borderRadius: BorderRadius.circular(16),
            child: SingleChildScrollView(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(color: colorScheme.surface, borderRadius: BorderRadius.circular(16)),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Create New Event',
                      style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold, color: colorScheme.onSurface),
                    ),
                    const SizedBox(height: 16),
                    Text('Thijhgjhg.', style: theme.textTheme.bodyMedium?.copyWith(color: colorScheme.onSurfaceVariant)),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: () => Navigator.of(context).pop(),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: colorScheme.primary,
                        foregroundColor: colorScheme.onPrimary,
                      ),
                      child: const Text('Close'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CustomFloatingActionButton extends StatelessWidget {
  const CustomFloatingActionButton({
    super.key,
    this.onButtonPress,
    this.rightPadding = 16,
    this.bottomPadding = 20,
    this.buttonIcon = Icons.add,
    this.isVisible = true,
  });

  final VoidCallback? onButtonPress;
  final double rightPadding;
  final double bottomPadding;
  final IconData buttonIcon;
  final bool isVisible;

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: isVisible ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 300),
      child: FloatingActionButton(
        heroTag: _addEventHeroTag,
        onPressed: () {
          onButtonPress?.call();
          Navigator.of(context).push(HeroDialogRoute(builder: (context) => const _AddEventPopupCard()));
        },
        child: Icon(buttonIcon),
      ),
    );
  }
}
