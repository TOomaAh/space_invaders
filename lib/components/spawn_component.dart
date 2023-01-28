import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:fyc/components/game_component.dart';
import 'package:fyc/components/monster_component.dart';
import 'package:fyc/game/level/level.dart';
import 'package:fyc/game/level/level_one.dart';

import '../game/invaders.dart';

/// SpawnComponent is a Component
class SpawnComponent extends PositionComponent
    with CollisionCallbacks, HasGameRef<InvadersGame> {
  /// SpawnComponent is a Component
  SpawnComponent({
    this.level = 1,
  }) : super(position: Vector2(10, 50));

  /// child is the component to spawn
  final List<Level> levels = [LevelOne()];

  /// level to load
  final int level;
  double _moveTime = 0;
  final double _movementSpeed = .5;
  bool _right = true;

  @override
  Future<void> onLoad() async {
    final gameComponent = parent! as GameComponent;
    size = Vector2(gameComponent.size.x, gameComponent.size.y * 0.5);
    final childToSpawn = levels[level - 1].getComponent();
    final nbrOfRow = size.y / 80;
    final nbrOfColumn = size.x / 130;

    // for each row spawn the component
    for (var i = 0; i < nbrOfRow; i++) {
      // for each column spawn the component
      for (var j = 0; j < nbrOfColumn; j++) {
        if (i > childToSpawn.length - 1) {
          // spawn default component
          await add(
            MonsterComponent()..position = Vector2(10 + j * 80, 10 + i * 50),
          );
        } else {
          // spawn the component
          await add(
            (childToSpawn[i][0] as MonsterComponent).clone()
              ..position = Vector2(10 + j * 80, 10 + i * 50),
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
      if (_right) {
        position.x += 200 * dt;
      } else {
        position.x -= 200 * dt;
      }
    }
    super.update(dt);
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);
    if (other is ScreenHitbox) {
      _right = !_right;
      position = position + Vector2(0, 200);
    }
  }
}
