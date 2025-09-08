import 'package:flutter/material.dart';

class CircularProgressBar extends StatefulWidget {
  final CircularProgressIndicator progressIndicator;
  const CircularProgressBar({super.key, required this.progressIndicator});

  @override
  State<CircularProgressBar> createState() => _CircularProgressBarState();
}

class _CircularProgressBarState extends State<CircularProgressBar> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(duration: const Duration(seconds: 2), vsync: this);
    _animationController.repeat();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Transform.rotate(angle: _animationController.value * 2 * 3.14159, child: widget.progressIndicator);
      },
    );
  }
}
