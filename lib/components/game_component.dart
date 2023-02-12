import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:fyc/components/monster/monster.dart';
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
  GameComponent({required this.playerData}) : super(position: Vector2(10, 10)) {
    _player = ShipComponent(
      position: Vector2(0, 0),
      size: Vector2(50, 50),
    );
  }

  /// List of levels
  final levels = [LevelOne()];
  int _currentLevel = 0;

  // levels getter
  List<Level> get level => levels;

  /// PlayerData
  PlayerData playerData;

  late ShipComponent _player;

  @override
  Future<void>? onLoad() async {
    size = Vector2(
      gameRef.size.x - 60,
      gameRef.size.y * .95,
    );

    game.overlays.add('score');
    final components = <Component>[
      ScreenHitbox(),
      BackButtonCustom(gameComponent: this),
      PauseButton(),
      _player
        ..position = Vector2(
          gameRef.size.x / 2,
          gameRef.size.y * .90,
        ),
      SpawnComponent(level: levels[0]),
    ];
    await addAll(components);
    await super.onLoad();
  }

  void resetGame() {
    this
      ..removeAll(children.whereType<SpawnComponent>())
      ..add(SpawnComponent(level: levels[0]));
  }

  void _gameIsFinished() {
    if (_currentLevel == levels.length - 1) {
      gameRef.overlays.remove('score');
      gameRef.overlays.add('menu');
      return;
    }
    this
      ..removeAll(children.whereType<SpawnComponent>())
      ..add(SpawnComponent(level: levels[_currentLevel += 1]));
  }

  @override
  Future<void> update(double dt) async {
    if (children.whereType<SpawnComponent>().isEmpty) {
      _gameIsFinished();
    }
  }

  void gameOver() {
    resetGame();
    gameRef.overlays.remove('score');
    gameRef.overlays.add('gameOver');
  }

  /// Called when the component is removed from the game
  void increaseScore() {
    playerData.score.value++;
  }

  @override
  void onGameResize(Vector2 size) {
    this.size = Vector2(
      gameRef.size.x - 60,
      gameRef.size.y * .95,
    );

    _player.position.y = gameRef.size.y * .90;

    if (_player.position.x > gameRef.size.x - 50) {
      _player.position.x = gameRef.size.x - 50;
    }

    super.onGameResize(size);
  }
}
