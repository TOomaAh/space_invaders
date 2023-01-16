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
  MonsterComponent({required Vector2 position}) {
    size = Vector2.all(30);
    this.position = position;
  }

  final String _initialMove = 'monster_initial.png';
  final String _move = 'monster_move.jpg';
  int _health = 100;
  late InvadersGame _game;
  var _currentState = MonsterState.idle;

  final _animationSpeed = .2;
  var _animationTime = 0.0;

  final _movementSpeed = .5;
  var _movementTime = 0.0;

  double _direction = 1;

  @override
  Future<void>? onLoad() async {
    await super.onLoad();
    _game = findGame()! as InvadersGame;
    await add(RectangleHitbox());
    sprite = await Sprite.load(_initialMove);
  }

  void move() {
    if (_game.size.x - position.x < findGame()!.size.x - 10) {
      position = position + Vector2(-10 * _direction, 30);
    } else {
      position = position + Vector2(10, 0);
      _direction *= -1;
    }
  }

  void takeDamage(int damage) {
    _health -= damage;
    if (_health <= 0) {
      _game.remove(this);
      removeFromParent();
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
