// ignore: public_member_api_docs
import 'package:flame/collisions.dart' show CollisionCallbacks, RectangleHitbox;
import 'package:flame/components.dart'
    show HasGameRef, KeyboardHandler, Sprite, SpriteComponent, Vector2;
import 'package:flame_audio/flame_audio.dart' show FlameAudio;
import 'package:flutter/services.dart'
    show LogicalKeyboardKey, RawKeyEvent, RawKeyUpEvent;
import 'package:fyc/components/laser_component.dart';
import 'package:fyc/game/invaders.dart';

/// ShipComponent is a SpriteComponent
class ShipComponent extends SpriteComponent
    with CollisionCallbacks, KeyboardHandler, HasGameRef<InvadersGame> {
  /// Create a new ShipComponent at the given inside [game]
  ShipComponent({
    required Vector2 position,
    required Vector2 size,
  }) : super(
          position: position,
          size: size,
        );

  final String _assetPath = 'player.png';
  bool _isFire = false;
  _ShipDirection _direction = _ShipDirection.none;

  @override
  Future<void>? onLoad() async {
    await super.onLoad();
    await add(RectangleHitbox());
    sprite = Sprite(gameRef.images.fromCache(_assetPath));
  }

  @override
  bool onKeyEvent(RawKeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    if (event.logicalKey == LogicalKeyboardKey.space) {
      _isFire = true;
    } else if (event.logicalKey == LogicalKeyboardKey.arrowLeft) {
      _direction = _ShipDirection.left;
    } else if (event.logicalKey == LogicalKeyboardKey.arrowRight) {
      _direction = _ShipDirection.right;
    }

    if (event is RawKeyUpEvent &&
        event.logicalKey != LogicalKeyboardKey.space) {
      _direction = _ShipDirection.none;
    }
    return true;
  }

  Future<void> _fire() async {
    _isFire = false;
    if (parent == null ||
        parent!.children.whereType<LaserComponent>().isNotEmpty) {
      return;
    } else {
      await FlameAudio.play('laser.mp3');
      await parent!.add(
        LaserComponent(
          position: position + Vector2(10, -40),
        ),
      );
    }
  }

  @override
  Future<void> update(double dt) async {
    if (_isFire) {
      await _fire();
    }
    if (position.x < 0 && _direction == _ShipDirection.left) {
      return;
    } else if (position.x > gameRef.size.x - size.x &&
        _direction == _ShipDirection.right) {
      return;
    }

    if (_direction == _ShipDirection.left) {
      position = position - Vector2(50, 0) * dt;
    } else if (_direction == _ShipDirection.right) {
      position = position + Vector2(50, 0) * dt;
    }
    super.update(dt);
  }

  @override
  void onGameResize(Vector2 size) {
    super.onGameResize(size);
  }
}

enum _ShipDirection { left, right, none }
