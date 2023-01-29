import 'dart:async';
import 'dart:io';
import 'package:flame/components.dart';
import 'package:flame/experimental.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:fyc/components/game_component.dart';
import 'package:fyc/game/menu/start_menu.dart';
import 'package:fyc/game/player_data.dart';

/// InvadersGame is a Game
class InvadersGame extends FlameGame
    with
        HasCollisionDetection,
        HasKeyboardHandlerComponents,
        HasTappableComponents {
  late final RouterComponent router;
  bool _hasFire = false;

  final playerData = PlayerData();

  @override
  Future<void>? onLoad() async {
    final gameComponent = GameComponent(playerData: playerData);

    await add(
      router = RouterComponent(
        initialRoute: 'menu',
        routes: {
          'menu': Route(StartMenu.new),
          'start': Route(() => gameComponent),
          'leave': Route(() => exit(0)),
        },
      ),
    );
    await super.onLoad();
  }
}
