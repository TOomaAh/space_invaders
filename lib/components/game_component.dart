import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fyc/components/monster_component.dart';
import 'package:fyc/components/pause_button.dart';
import 'package:fyc/components/ship_component.dart';
import 'package:fyc/components/spawn_component.dart';
import 'package:fyc/game/invaders.dart';
import 'package:fyc/game/level/level.dart';
import 'package:fyc/game/level/level_one.dart';
import 'package:fyc/game/player_data.dart';
import 'package:fyc/ui/simple_button.dart';

/// GameComponent is a PositionComponent
class GameComponent extends PositionComponent
    with CollisionCallbacks, HasGameRef<InvadersGame> {
  /// GameComponent is a PositionComponent
  GameComponent({required this.playerData}) : super(position: Vector2(10, 10));

  /// List of levels
  final levels = [LevelOne()];
  int _currentLevel = 0;

  // levels getter
  List<Level> get level => levels;

  /// PlayerData
  PlayerData playerData;

  @override
  Future<void>? onLoad() async {
    print('GameComponent.onLoad()');
    size = Vector2(
      gameRef.size.x - 60,
      gameRef.size.y * .95,
    );

    game.overlays.add('score');
    final components = <Component>[
      ScreenHitbox(),
      BackButtonCustom(gameComponent: this),
      PauseButton(),
      ShipComponent(
        //position is 1/2 of the screen width and 3/4 of the screen height
        position: Vector2(
          gameRef.size.x / 2,
          gameRef.size.y * 0.75,
        ),
        size: Vector2(50, 50),
      ),
      SpawnComponent(level: levels[0]),
    ];
    await addAll(components);
    await super.onLoad();
  }

  @override
  void onGameResize(Vector2 size) {
    this.size = Vector2(
      gameRef.size.x - 60,
      gameRef.size.y * .95,
    );

    // scale the children
    for (final element in children) {
      if (element is MonsterComponent) {
        element.onGameResize(size);
      }
    }
    super.onGameResize(size);
  }

  /// Called when the component is removed from the game
  void increaseScore() {
    playerData.score.value++;
  }

  void _isGameOver() async {
    final spawnComponent = children
        .firstWhere((element) => element is SpawnComponent) as SpawnComponent;

    if (spawnComponent.children.isEmpty) {
      remove(spawnComponent);
      if (_currentLevel < levels.length - 1) {
        _currentLevel++;
        await add(SpawnComponent(level: levels[_currentLevel]));
      } else {
        // game over
        gameRef.router.pop();
      }
    }
  }
}
