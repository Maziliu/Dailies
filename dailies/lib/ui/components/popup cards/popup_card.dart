import 'package:dailies/ui/components/popup%20cards/add_event_popup_card.dart';
import 'package:dailies/ui/components/ui_formating.dart';
import 'package:flutter/material.dart';

class PopupCard extends StatelessWidget {
  final Widget _innerContentWidget;
  final String _heroTag;

  const PopupCard({super.key, required Widget innerContentWidget, required String heroTag}) : _innerContentWidget = innerContentWidget, _heroTag = heroTag;

  factory PopupCard.AddEvent({
    Key? key,
    required void Function(String, String?, DateTime?, DateTime?) onSubmit,
    required DateTime selectedDay,
    required String heroTag,
  }) {
    return PopupCard(innerContentWidget: AddEventPopupCard(onSubmit: onSubmit, heroTag: heroTag, selectedDay: selectedDay), heroTag: heroTag);
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
