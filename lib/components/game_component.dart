import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:fyc/components/monster_component.dart';
import 'package:fyc/components/pause_button.dart';
import 'package:fyc/components/ship_component.dart';
import 'package:fyc/components/spawn_component.dart';
import 'package:fyc/game/invaders.dart';
import 'package:fyc/game/level/level_one.dart';
import 'package:fyc/ui/simple_button.dart';

/// GameComponent is a PositionComponent
class GameComponent extends Component
    with CollisionCallbacks, HasGameRef<InvadersGame> {
  @override
  Future<void>? onLoad() async {
    final levels = [LevelOne()];

    final components = <Component>[
      ScreenHitbox(),
      BackButton(),
      PauseButton(),
      ShipComponent(
        //position is 1/2 of the screen width and 3/4 of the screen height
        position: Vector2(
          gameRef.size.x / 2,
          gameRef.size.y * 0.75,
        ),
        size: Vector2(50, 50),
      ),
      SpawnComponent(),
    ];

    await game.addAll(components);
    await super.onLoad();
  }
}
