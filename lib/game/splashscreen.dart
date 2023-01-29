import 'package:flame/game.dart';
import 'package:flame_splash_screen/flame_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:fyc/game/invaders.dart';
import 'package:fyc/ui/game_over.dart';
import 'package:fyc/ui/pause_component.dart';
import 'package:fyc/ui/score_component.dart';

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
          return const Image(image: AssetImage('assets/images/esgi_logo.png'));
        },
        showAfter: (BuildContext context) {
          return const Image(
            image: AssetImage('assets/images/space_invaders_logo.png'),
          );
        },
        theme: FlameSplashTheme.dark,
        onFinish: (context) => Navigator.pushReplacement<void, void>(
          context,
          MaterialPageRoute(
            builder: (context) => GameWidget<InvadersGame>(
              game: widget.game,
              overlayBuilderMap: {
                'pause': (context, InvadersGame game) => PauseMenu(
                      game: game,
                    ),
                'gameOver': (context, InvadersGame game) => GameOver(
                      game: game,
                    ),
                'score': (context, InvadersGame game) => ScoreWidget(
                      game: game,
                    ),
              },
            ),
          ),
        ),
      ),
    );
  }
}
