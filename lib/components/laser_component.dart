import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/painting.dart';

import 'package:fyc/game/invaders.dart';

import 'monster_component.dart';

/// LaserComponent is a SpriteComponent
class LaserComponent extends SpriteComponent with CollisionCallbacks {
  /// Create a new LaserComponent at the given inside [game]
  LaserComponent({
    required Vector2 position,
    required InvadersGame game,
  }) : super(position: position) {
    size = Vector2.all(30);
    _game = game;
  }

  final String _assetPath = 'laser.png';
  late InvadersGame _game;

  @override
  Future<void>? onLoad() async {
    await super.onLoad();
    await add(RectangleHitbox());
    sprite = await Sprite.load(_assetPath);
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);
    if (other is MonsterComponent) {
      _game.remove(this);
      other.removeFromParent();
      //FlameAudio.play('explosion.mp3');
    }
  }

  @override
  void update(double dt) {
    position.y -= 10;

    if (position.y < 100) {
      removeFromParent();
    }

    super.update(dt);
  }
}
