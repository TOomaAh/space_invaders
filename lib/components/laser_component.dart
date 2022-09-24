import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/painting.dart';

import '../game/invaders.dart';

class LaserComponent extends SpriteComponent with CollisionCallbacks {
  final String _assetPath = 'laser.png';
  // ignore: public_member_api_docs
  LaserComponent({
    required Vector2 position,
    required InvadersGame game,
  }) : super(position: position) {
    size = Vector2.all(30);
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
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);
    remove(this);
  }

  @override
  void update(double dt) {
    // TODO: implement update
    position.y -= 10;

    if (position.y < 100) {
      _game.remove(this);
    }
    super.update(dt);
  }
}
