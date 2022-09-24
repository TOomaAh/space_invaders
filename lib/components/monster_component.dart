import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:fyc/game/invaders.dart';

/// Monster movement state
enum MonsterState {
  /// MonsterState.idle is Monster initial state
  idle,

  /// Monster is moving right
  moving,
}

/// MonsterComponent is a SpriteComponent
class MonsterComponent extends SpriteComponent with CollisionCallbacks {
  /// Create a new MonsterComponent at the given inside [game]
  MonsterComponent() {
    size = Vector2.all(30);
    position = Vector2(100, 100);
  }

  final String _initialMove = 'monster_initial.png';
  final String _move = 'monster_move.jpg';

  late InvadersGame _game;
  var _currentState = MonsterState.idle;

  final _animationSpeed = .2;
  var _animationTime = 0.0;

  final _movementSpeed = .5;
  var _movementTime = 0.0;

  @override
  Future<void>? onLoad() async {
    await super.onLoad();
    _game = findGame()! as InvadersGame;
    await add(RectangleHitbox());
    sprite = await Sprite.load(_initialMove);
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);
    _game.remove(this);
  }

  void move() {
    if (_game.size.x - position.x < 30) {
      position = position + Vector2(-10, 30);
    } else {
      position = position + Vector2(10, 0);
    }
  }

  @override
  void update(double dt) async {
    _animationTime += dt;
    _movementTime += dt;
    if (_animationTime >= _animationSpeed) {
      _animationTime = 0.0;
      if (_currentState == MonsterState.idle) {
        _currentState = MonsterState.moving;
        sprite = Sprite(_game.images.fromCache(_move));
      } else {
        _currentState = MonsterState.idle;
        sprite = Sprite(_game.images.fromCache(_initialMove));
      }
      _animationTime = 0;
    }

    if (_movementTime >= _movementSpeed) {
      _movementTime = 0;
      move();
    }
    super.update(dt);
  }
}
