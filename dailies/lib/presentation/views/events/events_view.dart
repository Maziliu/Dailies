import 'package:dailies/presentation/views/events/events_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EventsView extends StatelessWidget {
  const EventsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<EventsViewModel>(
      builder: (context, viewModel, child) {
        return const Center(child: Text('Events'));
      },
    );
  }
}
