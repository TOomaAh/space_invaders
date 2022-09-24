import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:fyc/game/invaders.dart';

class MonsterComponent extends SpriteComponent with CollisionCallbacks {
  final String _assetPath = 'monster_initial.png';
  // ignore: public_member_api_docs
  MonsterComponent({required InvadersGame game}) {
    _game = game;
    size = Vector2.all(30);
    position = Vector2(100, 100);
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
    _game.remove(this);
  }
}
