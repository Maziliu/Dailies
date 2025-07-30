import 'package:flutter/material.dart';

class CustomFloatingActionButton extends StatelessWidget {
  const CustomFloatingActionButton({
    super.key,
    required void Function() onButtonPress,
    double rightPadding = 16,
    double bottomPadding = 20,
    IconData buttonIcon = Icons.add,
    bool isVisible = true,
  }) : _buttonIcon = buttonIcon,
       _bottomPadding = bottomPadding,
       _rightPadding = rightPadding,
       _onButtonPress = onButtonPress,
       _isVisible = isVisible;

  final VoidCallback _onButtonPress;
  final double _rightPadding;
  final double _bottomPadding;
  final IconData _buttonIcon;
  final bool _isVisible;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: _bottomPadding,
      right: _rightPadding,
      child: AnimatedOpacity(
        opacity: _isVisible ? 1.0 : 0.0,
        duration: const Duration(milliseconds: 300),
        child: FloatingActionButton(
          onPressed: _onButtonPress,
          child: Icon(_buttonIcon),
        ),
      ),
    );
  }
}
