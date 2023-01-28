import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
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
  }) : super(anchor: Anchor.topLeft);

  /// child is the component to spawn
  final List<Level> levels = [LevelOne()];

  /// level to load
  final int level;
  double _moveTime = .0;
  final double _movementSpeed = .5;
  final bool right = true;

  @override
  void onLoad() {
    position = gameRef.size / 2;
    size = Vector2(gameRef.size.x - 20, gameRef.size.y * 0.5);
    final childToSpawn = levels[level - 1].getComponent();
    final nbrOfRow = size.y / 80;
    final nbrOfColumn = size.x / 130;

    // for each row spawn the component
    for (var i = 0; i < nbrOfRow; i++) {
      // for each column spawn the component
      for (var j = 0; j < nbrOfColumn; j++) {
        if (i > childToSpawn.length - 1) {
          gameRef.add(
            MonsterComponent()..position = Vector2(10 + j * 80, 10 + i * 50),
          );
        } else {
          // spawn the component
          gameRef.add(
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
      if (right) {
        position = position + Vector2(10, 0) * dt;
      } else {
        position = position - Vector2(10, 0) * dt;
      }
    }
    super.update(dt);
  }
}
