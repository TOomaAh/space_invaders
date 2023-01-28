import 'package:flame/components.dart';
import 'package:fyc/components/monster_component.dart';
import 'package:fyc/game/invaders.dart';

class LevelOne extends Component with HasGameRef<InvadersGame> {
  List<Component> getComponent() {
    final monsters = <Component>[];
    //for 1 to 20
    for (var i = 0; i < 10; i++) {
      //create a new monster
      final monster = MonsterComponent(position: Vector2(40 + i * 40, 30));
      //add monster to monsters
      monsters.add(monster);
    }
    return [
      ...monsters,
    ];
  }

  /// return true if all monsters are dead
  bool gameIsFinished() {
    final child = gameRef.children;
    for (final element in child) {
      if (element is MonsterComponent) {
        return false;
      }
    }
    return true;
  }
}