import 'package:dailies/data/models/stamina.dart';
import 'package:dailies/ui/components/stamina%20tracker/stamina_widget.dart';
import 'package:dailies/ui/components/ui_formating.dart';
import 'package:flutter/material.dart';

class OverviewView extends StatefulWidget {
  const OverviewView({super.key});

  @override
  State<OverviewView> createState() => _OverviewViewState();
}

class _OverviewViewState extends State<OverviewView> {
  @override
  Widget build(BuildContext context) {
    List tests = [
      Stamina(
        id: 3,
        rechargeTime: const Duration(minutes: 6),
        maxStamina: 240,
        gachaTitle: 'WuWa',
        imageName: 'waveplate.png',
        timeOfLastReset: DateTime.now().subtract(const Duration(hours: 4)),
        staminaOfLastestReset: 93,
      ),
      Stamina(
        id: 3,
        rechargeTime: const Duration(minutes: 6),
        maxStamina: 300,
        gachaTitle: 'HSR',
        imageName: 'trailblaze_power.png',
        timeOfLastReset: DateTime.now().subtract(const Duration(hours: 2)),
        staminaOfLastestReset: 22,
      ),
      Stamina(
        id: 3,
        rechargeTime: const Duration(minutes: 6),
        maxStamina: 240,
        gachaTitle: 'ZZZ',
        imageName: 'battery_charge.png',
        timeOfLastReset: DateTime.now().subtract(const Duration(hours: 5)),
        staminaOfLastestReset: 0,
      ),
      Stamina(
        id: 3,
        rechargeTime: const Duration(minutes: 6),
        maxStamina: 240,
        gachaTitle: 'AK',
        imageName: 'sanity.png',
        timeOfLastReset: DateTime.now().subtract(const Duration(hours: 1)),
        staminaOfLastestReset: 132,
      ),
      Stamina(
        id: 3,
        rechargeTime: const Duration(minutes: 8),
        maxStamina: 200,
        gachaTitle: 'GI',
        imageName: 'resin.png',
        timeOfLastReset: DateTime.now().subtract(const Duration(hours: 8)),
        staminaOfLastestReset: 99,
      ),
      Stamina(
        id: 3,
        rechargeTime: const Duration(minutes: 4),
        maxStamina: 154,
        gachaTitle: 'E7',
        imageName: 'e7_energy.png',
        timeOfLastReset: DateTime.now().subtract(const Duration(hours: 9)),
        staminaOfLastestReset: 74,
      ),
    ];

    return Padding(padding: UIFormating.smallPadding(), child: Wrap(children: tests.map((e) => StaminaWidget(stamina: e)).toList()));
  }
}
