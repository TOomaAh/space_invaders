// ignore: public_member_api_docs
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flame/flame.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:fyc/components/laser_component.dart';
import 'package:fyc/game/invaders.dart';

class ShipComponent extends SpriteComponent
    with CollisionCallbacks, KeyboardHandler {
  final String _assetPath = 'ship.png';
  // ignore: public_member_api_docs
  ShipComponent({
    required Vector2 position,
    required Vector2 size,
    required InvadersGame game,
  }) : super(
          position: position,
          size: size,
        ) {
    _game = game;
  }

  late InvadersGame _game;

  @override
  Future<void>? onLoad() async {
    await super.onLoad();
    await add(RectangleHitbox());
    sprite = await Sprite.load(_assetPath);
  }

  @override
  bool onKeyEvent(RawKeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    if (keysPressed.contains(LogicalKeyboardKey.space)) {
      _game.add(LaserComponent(
        position: position + Vector2(10, -40),
        game: _game,
      ));
    } else if (keysPressed.contains(LogicalKeyboardKey.arrowLeft)) {
      position = position - Vector2(10, 0);
    } else if (keysPressed.contains(LogicalKeyboardKey.arrowRight)) {
      position = position + Vector2(10, 0);
    }
    return true;
  }
}
