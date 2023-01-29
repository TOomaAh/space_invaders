import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
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
    required this.level,
  }) : super(position: Vector2(10, 100));

  /// Level to load
  final Level level;

  double _moveTime = 0;
  final double _movementSpeed = 1;
  double _right = 1;

  @override
  Future<void> onLoad() async {
    final gameComponent = parent! as GameComponent;
    size = Vector2(gameComponent.size.x, gameComponent.size.y * 0.5);
    await add(RectangleHitbox());
    await _addAllMonster();
  }

  Future<void> _addAllMonster() async {
    final childToSpawn = level.getComponent();
    final sizeOfOneRow = size.y / 7;
    final sizeOfOneColumn = size.x / 12;

    final center = Vector2(sizeOfOneColumn / 2, sizeOfOneRow / 2);

    // for each row spawn the component
    for (var i = 0; i < 7; i++) {
      // for each column spawn the component
      for (var j = 0; j < 12; j++) {
        if (i > childToSpawn.length - 1) {
          // spawn default component
          await add(
            MonsterComponent()
              ..position =
                  Vector2(j * sizeOfOneColumn, i * sizeOfOneRow) + center,
          );
        } else {
          // spawn the component
          await add(
            (childToSpawn[i][0] as MonsterComponent).clone()
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
      _right = -_right;
      position
        ..y += 20
        ..x += 10 * _right;
    }
  }

  @override
  void onGameResize(Vector2 size) {
    super.onGameResize(size);
  }
}
