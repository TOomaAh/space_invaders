import 'dart:async';
import 'dart:io';
import 'package:flame/experimental.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:fyc/components/game_component.dart';
import 'package:fyc/components/pause_component.dart';
import 'package:fyc/game/menu/start_menu.dart';

/// InvadersGame is a Game
class InvadersGame extends FlameGame
    with
        HasCollisionDetection,
        HasKeyboardHandlerComponents,
        HasTappableComponents {
  late final RouterComponent router;
  bool _hasFire = false;

  @override
  Future<void>? onLoad() async {
    await add(
      router = RouterComponent(
        initialRoute: 'menu',
        routes: {
          'menu': Route(StartMenu.new),
          'start': Route(GameComponent.new),
          //'pause': Route(PauseComponent.new),
          'leave': Route(() => exit(0)),
        },
      ),
    );
    await super.onLoad();
  }
}
