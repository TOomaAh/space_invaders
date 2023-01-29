import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/foundation.dart';
import 'package:fyc/components/laser_component.dart';
import 'package:fyc/game/invaders.dart';

/// Monster movement state
enum MonsterState {
  /// MonsterState.idle is Monster initial state
  idle,

  /// Monster is moving right
  moving,
}

/// MonsterComponent is a SpriteComponent
class MonsterComponent extends SpriteComponent
    with CollisionCallbacks, HasGameRef<InvadersGame> {
  /// Create a new MonsterComponent at the given inside [game]
  MonsterComponent() {
    size = Vector2.all(30);
    position = _initialPosition;
    anchor = Anchor.center;
  }
  final Vector2 _initialPosition = Vector2(0, 0);
  final String _initialMove = 'monster_initial.png';
  final String _move = 'monster_move.jpg';
  int _health = 100;
  var _currentState = MonsterState.idle;

  final _animationSpeed = .2;
  var _animationTime = 0.0;

  @override
  Future<void>? onLoad() async {
    await super.onLoad();

    await add(RectangleHitbox());
    sprite = await Sprite.load(_initialMove);
  }

  void _takeDamage(int damage) {
    _health -= damage;
    if (_health <= 0) {
      removeFromParent();
    }
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is LaserComponent) {
      _takeDamage(other.damage);
      removeFromParent();
    }
    super.onCollision(intersectionPoints, other);
  }

  @override
  void update(double dt) async {
    _animationTime += dt;
    if (_animationTime >= _animationSpeed) {
      _animationTime = 0.0;
      if (_currentState == MonsterState.idle) {
        _currentState = MonsterState.moving;
        sprite = Sprite(gameRef.images.fromCache(_move));
      } else {
        _currentState = MonsterState.idle;
        sprite = Sprite(gameRef.images.fromCache(_initialMove));
      }
      _animationTime = 0;
    }

    super.update(dt);
  }

  /// implements clone method
  MonsterComponent clone() {
    return MonsterComponent()
      ..sprite = sprite
      ..size = size
      ..position = position;
  }
}
