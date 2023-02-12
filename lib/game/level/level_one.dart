import 'package:fyc/components/monster/mega_monster_component.dart';
import 'package:fyc/components/monster/monster.dart';
import 'package:fyc/components/monster/simple_monster_component.dart';
import 'package:fyc/game/invaders.dart';
import 'package:fyc/game/level/level.dart';

/// Level One is the first level
class LevelOne extends Level {
  final List<List<Monster Function()>> monsters = [
    [MegaMonsterComponent.new],
    [SimpleMonsterComponent.new],
    [SimpleMonsterComponent.new],
    [SimpleMonsterComponent.new],
    [SimpleMonsterComponent.new],
  ];

  @override
  List<List<Monster Function()>> getComponent() {
    return monsters;
  }

  @override
  bool gameIsFinished(InvadersGame gameRef) {
    final child = gameRef.children;
    for (final element in child) {
      if (element is Monster) {
        return false;
      }
    }
    return true;
  }
}
