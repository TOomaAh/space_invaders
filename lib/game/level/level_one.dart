import 'package:flame/components.dart';
import 'package:fyc/components/monster_component.dart';
import 'package:fyc/game/invaders.dart';
import 'package:fyc/game/level/level.dart';

/// Level One is the first level
class LevelOne extends Level {
  final monsters = [
    [MonsterComponent()],
    [MonsterComponent()],
    [MonsterComponent()],
    [MonsterComponent()],
    [MonsterComponent()],
  ];

  @override
  List<List<Component>> getComponent() {
    return monsters;
  }

  @override
  bool gameIsFinished(InvadersGame gameRef) {
    final child = gameRef.children;
    for (final element in child) {
      if (element is MonsterComponent) {
        return false;
      }
    }
    return true;
  }
}
