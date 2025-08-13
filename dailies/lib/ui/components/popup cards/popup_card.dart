import 'package:dailies/ui/components/popup%20cards/add_event_popup_card.dart';
import 'package:dailies/ui/components/popup%20cards/add_stamina_popup_card.dart';
import 'package:dailies/ui/components/popup%20cards/set_stamina_popup_card.dart';
import 'package:dailies/ui/components/ui_formating.dart';
import 'package:flutter/material.dart';

class PopupCard extends StatelessWidget {
  final Widget _innerContentWidget;
  final String _heroTag;

  const PopupCard({super.key, required Widget innerContentWidget, required String heroTag}) : _innerContentWidget = innerContentWidget, _heroTag = heroTag;

  factory PopupCard.AddEvent({Key? key, required DateTime selectedDay, required String heroTag}) {
    return PopupCard(innerContentWidget: AddEventPopupCard(heroTag: heroTag, selectedDay: selectedDay), heroTag: heroTag);
  }

  factory PopupCard.AddStamina({Key? key, required void Function(String, int, Duration, int, String?) onSubmit, required String heroTag}) {
    return PopupCard(innerContentWidget: AddStaminaPopupCard(onSubmit: onSubmit, heroTag: heroTag), heroTag: heroTag);
  }

  factory PopupCard.SetStamina({Key? key, required String heroTag}) {
    return PopupCard(innerContentWidget: SetStaminaPopupCard(heroTag: heroTag), heroTag: heroTag);
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Center(
      child: Padding(
        padding: UIFormating.extraLargePadding(),
        child: Hero(
          tag: _heroTag,
          child: Material(elevation: 0, borderRadius: UIFormating.mediumCircularBorderRadius(), color: colorScheme.surface, child: _innerContentWidget),
        ),
      ),
    );
  }
}
