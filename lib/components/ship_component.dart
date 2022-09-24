// ignore: public_member_api_docs
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flame/flame.dart';
import 'package:flame/sprite.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:fyc/components/laser_component.dart';
import 'package:fyc/game/invaders.dart';

/// ShipComponent is a SpriteComponent
class ShipComponent extends SpriteComponent
    with CollisionCallbacks, KeyboardHandler {
  /// Create a new ShipComponent at the given inside [game]
  ShipComponent({
    required Vector2 position,
    required Vector2 size,
  }) : super(
          position: position,
          size: size,
        ) {
    _game = findGame()! as InvadersGame;
  }

  final String _assetPath = 'ship.png';
  late InvadersGame _game;

  @override
  Future<void>? onLoad() async {
    await super.onLoad();
    await add(RectangleHitbox());
    sprite = Sprite(_game.images.fromCache(_assetPath));
  }

  @override
  bool onKeyEvent(RawKeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    if (keysPressed.contains(LogicalKeyboardKey.space)) {
      _game.add(
        LaserComponent(
          position: position + Vector2(10, -40),
        ),
      );
      FlameAudio.play('laser.mp3');
    } else if (keysPressed.contains(LogicalKeyboardKey.arrowLeft)) {
      position = position - Vector2(10, 0);
    } else if (keysPressed.contains(LogicalKeyboardKey.arrowRight)) {
      position = position + Vector2(10, 0);
    }
    return true;
  }
}
