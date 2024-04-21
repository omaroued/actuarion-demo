import 'package:flutter/material.dart';

class Bounce extends StatefulWidget {
  final VoidCallback? onPressed;
  final Widget child;
  final Duration duration;

  const Bounce(
      {Key? key, required this.child, this.duration = const Duration(milliseconds: 300), required this.onPressed})
      : super(key: key);

  @override
  BounceState createState() => BounceState();
}

class BounceState extends State<Bounce> with SingleTickerProviderStateMixin {
  late double _scale;

  late AnimationController _animate;

  VoidCallback? get onPressed => widget.onPressed;

  Duration get userDuration => widget.duration;

  @override
  void initState() {
    _animate =
        AnimationController(vsync: this, duration: const Duration(milliseconds: 200), lowerBound: 0.0, upperBound: 0.1)
          ..addListener(() {
            setState(() {});
          });
    super.initState();
  }

  @override
  void dispose() {
    _animate.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _scale = 1 - _animate.value;
    return GestureDetector(
        onTap: onPressed == null ? null : _onTap,
        behavior: HitTestBehavior.translucent,
        child: Transform.scale(
          scale: _scale,
          child: widget.child,
        ));
  }

  void _onTap() {
    _animate.forward();

    Future.delayed(userDuration, () {
      _animate.reverse();

      onPressed?.call();
    });
  }
}
