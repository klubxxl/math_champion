import 'package:animated_background/animated_background.dart';
import 'package:flutter/material.dart';

class AnimatedBackgroundWidget extends StatefulWidget {
  AnimatedBackgroundWidget({required this.child, Key? key}) : super(key: key);
  Widget child;
  @override
  State<AnimatedBackgroundWidget> createState() =>
      _AnimatedBackgroundWidgetState();
}

class _AnimatedBackgroundWidgetState extends State<AnimatedBackgroundWidget>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return AnimatedBackground(
        child: widget.child,
        vsync: this,
        behaviour: RandomParticleBehaviour(
            options: ParticleOptions(
          image: Image.asset('Assets/Images/equalSign.png'),
          spawnOpacity: 0.1,
          opacityChangeRate: 0.6,
          minOpacity: 0.1,
          maxOpacity: 0.4,
          spawnMinSpeed: 20.0,
          spawnMaxSpeed: 50.0,
          spawnMinRadius: 4.0,
          spawnMaxRadius: 32.0,
          particleCount: 20,
        )));
  }
}
