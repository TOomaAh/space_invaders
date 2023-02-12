import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/foundation.dart';
import 'package:fyc/components/laser_component.dart';
import 'package:fyc/components/monster/monster.dart';
import 'package:fyc/game/invaders.dart';

/// MonsterComponent is a SpriteComponent
class MegaMonsterComponent extends Monster {
  /// Create a new MonsterComponent at the given inside [game]
  MegaMonsterComponent() {
    size = Vector2.all(30);
    position = _initialPosition;
    anchor = Anchor.center;
  }

  final Vector2 _initialPosition = Vector2(0, 0);
  final String _assets = 'yellow.png';

  @override
  Future<void>? onLoad() async {
    health = 200;
    await add(RectangleHitbox());
    sprite = await Sprite.load(_assets);
    await super.onLoad();
  }

  /// implements clone method
  @override
  Monster clone() {
    return MegaMonsterComponent()
      ..sprite = sprite
      ..size = size
      ..position = position;
  }
}
