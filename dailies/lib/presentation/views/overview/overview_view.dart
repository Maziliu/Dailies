import 'package:dailies/presentation/views/overview/overview_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OverviewView extends StatelessWidget {
  const OverviewView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<OverviewViewModel>(
      builder: (context, viewModel, child) {
        return const Center(child: Text('Overview Content'));
      },
    );
  }
}
