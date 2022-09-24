import 'package:flame/game.dart';
import 'package:flame_splash_screen/flame_splash_screen.dart';
import 'package:flutter/material.dart';

import 'invaders.dart';

/// new Splashscreen
class SplashScreenGame extends StatefulWidget {
  /// Create a new SplashScreenGame
  SplashScreenGame({required this.game, super.key});

  late InvadersGame game;

  @override
  _SplashScreenGameState createState() => _SplashScreenGameState();
}

class _SplashScreenGameState extends State<SplashScreenGame> {
  late FlameSplashController controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FlameSplashScreen(
        showBefore: (BuildContext context) {
          return const Text('Before logo');
        },
        showAfter: (BuildContext context) {
          return const Text('After logo');
        },
        theme: FlameSplashTheme.dark,
        onFinish: (context) => Navigator.pushReplacement<void, void>(
          context,
          MaterialPageRoute(
            builder: (context) => GameWidget<InvadersGame>(
              game: widget.game,
            ),
          ),
        ),
      ),
    );
  }
}
