import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:fyc/game/invaders.dart';

import '../laser_component.dart';

abstract class Monster extends SpriteComponent
    with CollisionCallbacks, HasGameRef<InvadersGame> {
  int health = 100;

  /// implements clone method
  Monster clone();
  // ignore: public_member_api_docs
  void takeDamage(int damage) {
    health -= damage;
    if (health <= 0) {
      removeFromParent();
    }
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is LaserComponent) {
      takeDamage(other.damage);
    }
    super.onCollision(intersectionPoints, other);
  }
}
