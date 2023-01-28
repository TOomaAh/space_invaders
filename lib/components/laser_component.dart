import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/painting.dart';

import 'package:fyc/game/invaders.dart';

import 'monster_component.dart';

/// LaserComponent is a SpriteComponent
class LaserComponent extends SpriteComponent
    with CollisionCallbacks, HasGameRef<InvadersGame> {
  /// Create a new LaserComponent at the given inside [game]
  LaserComponent({
    required Vector2 position,
  }) : super(
          position: position,
        ) {
    size = Vector2.all(30);
  }

  final String _assetPath = 'laser.png';

  final int _damage = 100;

  @override
  Future<void>? onLoad() async {
    await super.onLoad();
    await add(RectangleHitbox());
    sprite = Sprite(game.images.fromCache(_assetPath));
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);
    if (other is MonsterComponent) {
      other
        ..takeDamage(_damage)
        ..removeFromParent();
      removeFromParent();
      //FlameAudio.play('explosion.mp3');
    }

    if (other is ScreenHitbox) {
      removeFromParent();
    }
  }

  @override
  void update(double dt) {
    position.y -= 500 * dt;

    super.update(dt);
  }
}
