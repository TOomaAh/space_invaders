import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:fyc/components/game_component.dart';
import 'package:fyc/components/monster/monster.dart';
import 'package:fyc/components/monster/simple_monster_component.dart';
import 'package:fyc/components/ship_component.dart';
import 'package:fyc/game/invaders.dart';
import 'package:fyc/game/level/level.dart';

/// SpawnComponent is a Component
class SpawnComponent extends PositionComponent
    with CollisionCallbacks, HasGameRef<InvadersGame> {
  /// SpawnComponent is a Component
  SpawnComponent({
    required this.level,
  }) : super(position: Vector2(10, 100));

  /// Level to load
  final Level level;

  double _moveTime = 0;
  double _movementSpeed = 1;
  double _right = 1;

  final int _speed = 200;

  final int _nbrRow = 5;
  final int _nbrColumn = 10;

  @override
  Future<void> onLoad() async {
    final gameComponent = parent! as GameComponent;
    size = Vector2(gameComponent.size.x, gameComponent.size.y * 0.5);
    await add(RectangleHitbox());
    await _addAllMonster();
  }

  Future<void> _addAllMonster() async {
    final childToSpawn = level.getComponent();
    final sizeOfOneRow = size.y / _nbrRow;
    final sizeOfOneColumn = size.x / _nbrColumn;

    final center = Vector2(sizeOfOneColumn / 2, sizeOfOneRow / 2);

    // for each row spawn the component
    for (var i = 0; i < _nbrRow; i++) {
      // for each column spawn the component
      for (var j = 0; j < _nbrColumn; j++) {
        if (i > childToSpawn.length - 1) {
          // spawn default component
          await add(
            SimpleMonsterComponent()
              ..position =
                  Vector2(j * sizeOfOneColumn, i * sizeOfOneRow) + center,
          );
        } else {
          // spawn the component
          await add(
            (childToSpawn[i][0]()).clone()
              ..position =
                  Vector2(j * sizeOfOneColumn, i * sizeOfOneRow) + center,
          );
        }
      }
    }
  }

  @override
  void update(double dt) {
    _moveTime += dt;
    if (_moveTime >= _movementSpeed) {
      _moveTime = .0;
      if (_right == 1) {
        position.x += _speed * dt;
      } else {
        position.x -= _speed * dt;
      }
      _movementSpeed > .5 ? _movementSpeed -= dt : _movementSpeed = .5;
    }
    super.update(dt);
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);
    if (other is ScreenHitbox) {
      _right = -_right;
      position
        ..y += 20
        ..x += 10 * _right;
    }

    if (other is ShipComponent) {
      (parent! as GameComponent).gameOver();
    }
  }

  @override
  void onGameResize(Vector2 size) {
    super.onGameResize(size);
  }
}
