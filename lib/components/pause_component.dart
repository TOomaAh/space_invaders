import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/experimental.dart';
import 'package:flame/game.dart';
import 'package:flame/rendering.dart';
import 'package:flutter/rendering.dart';
import 'package:fyc/game/invaders.dart';

class PauseComponent extends Component
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
  void onTapUp(TapUpEvent event) async {
    findGame()!.resumeEngine();
    gameRef.router.pop();
  }
}
