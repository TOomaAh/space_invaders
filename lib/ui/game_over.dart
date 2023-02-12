import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fyc/game/invaders.dart';

class GameOver extends StatelessWidget {
  /// Return a GameOver widget
  const GameOver({super.key, required this.game});

  final InvadersGame game;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: GestureDetector(
            onTap: () {
              game.overlays.remove('gameOver');
              game.router.pushReplacementNamed('menu');
            },
            child: ColoredBox(
              color: Colors.black.withOpacity(0.9),
              child: Center(
                child: AnimatedTextKit(
                  animatedTexts: [
                    ColorizeAnimatedText(
                      'Game Over',
                      textStyle: const TextStyle(fontSize: 50),
                      colors: const [
                        Colors.purple,
                        Colors.blue,
                        Colors.yellow,
                        Colors.red,
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
