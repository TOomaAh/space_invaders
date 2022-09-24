import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:fyc/components/monster_component.dart';
import 'package:fyc/components/ship_component.dart';

class InvadersGame extends FlameGame
    with HasCollisionDetection, HasKeyboardHandlerComponents, HasTappables {
  @override
  Future<void>? onLoad() async {
    await super.onLoad();
    await Flame.device.fullScreen();
    await Flame.device.setLandscape();

    final components = <SpriteComponent>[
      ShipComponent(
        //position is 1/2 of the screen width and 3/4 of the screen height
        position: Vector2(
          size.x / 2,
          size.y * 0.75,
        ),
        size: Vector2(50, 50),
        game: this,
      ),
      MonsterComponent(game: this),
    ];

    await addAll(components);
  }
}
