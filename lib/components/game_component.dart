import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:fyc/components/monster_component.dart';
import 'package:fyc/components/pause_button.dart';
import 'package:fyc/components/ship_component.dart';
import 'package:fyc/game/invaders.dart';
import 'package:fyc/ui/simple_button.dart';

/// GameComponent is a PositionComponent
class GameComponent extends Component {
  @override
  Future<void>? onLoad() async {
    final game = findGame()! as InvadersGame;

    final components = <Component>[
      BackButton(),
      PauseButton(),
      ShipComponent(
        //position is 1/2 of the screen width and 3/4 of the screen height
        position: Vector2(
          game.size.x / 2,
          game.size.y * 0.75,
        ),
        size: Vector2(50, 50),
        game: game,
      ),
      MonsterComponent(),
    ];

    await game.addAll(components);
    await super.onLoad();
  }
}
