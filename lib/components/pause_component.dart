import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/experimental.dart';
import 'package:flame/game.dart';
import 'package:flame/rendering.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fyc/game/invaders.dart';

class PauseMenu extends StatelessWidget {
  const PauseMenu({Key? key, required this.game}) : super(key: key);

  final InvadersGame game;

  @override
  Widget build(BuildContext context) {
    // Text 'paused' in the middle of the screen with a scale effect on it
    // click anywhere to resume the game
    return Stack(
      children: [
        Positioned.fill(
          child: GestureDetector(
            onTap: () {
              game.resumeEngine();
              game.overlays.remove('pause');
            },
            child: ColoredBox(
              color: Colors.black.withOpacity(0.5),
              child: const Center(
                child: Text(
                  'PAUSED',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 50,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

/*class PauseComponent extends Component
    with TapCallbacks, HasGameRef<InvadersGame> {
  @override
  Future<void> onLoad() async {
    final game = findGame()!;
    await addAll([
      TextComponent(
        text: 'PAUSED',
        position: game.canvasSize / 2,
        anchor: Anchor.center,
        children: [
          ScaleEffect.to(
            Vector2.all(1.1),
            EffectController(
              duration: 0.3,
              alternate: true,
              infinite: true,
            ),
          )
        ],
      ),
    ]);
  }

  @override
  bool containsLocalPoint(Vector2 point) => true;

  @override
  void onTapUp(TapUpEvent event) {
    game.resumeEngine();
    gameRef.router.pop();
  }
}
*/