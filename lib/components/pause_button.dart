import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/experimental.dart';
import 'package:flame/game.dart';
import 'package:flame/rendering.dart';
import 'package:flutter/rendering.dart';
import 'package:fyc/game/invaders.dart';
import 'package:fyc/ui/simple_button.dart';

/// PauseButton is a SimpleButton
class PauseButton extends SimpleButton with HasGameRef<InvadersGame> {
  /// Pause button
  PauseButton()
      : super(
          Path()
            ..moveTo(14, 10)
            ..lineTo(14, 30)
            ..moveTo(26, 10)
            ..lineTo(26, 30),
          position: Vector2(60, 10),
        );
  @override
  void action() {
    gameRef.overlays.add('pause');
    gameRef.pauseEngine();
  }
}
