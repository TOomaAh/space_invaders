import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:fyc/components/monster_component.dart';
import 'package:fyc/components/ship_component.dart';
import 'package:fyc/game/invaders.dart';

class GameComponent extends Component {
  @override
  Future<void>? onLoad() async {
    final _game = findGame()! as InvadersGame;

    final components = <SpriteComponent>[
      ShipComponent(
        //position is 1/2 of the screen width and 3/4 of the screen height
        position: Vector2(
          _game.size.x / 2,
          _game.size.y * 0.75,
        ),
        size: Vector2(50, 50),
      ),
      MonsterComponent(),
    ];

    await addAll(components);
  }
}
