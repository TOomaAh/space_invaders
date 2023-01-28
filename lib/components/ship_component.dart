// ignore: public_member_api_docs
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flame/flame.dart';
import 'package:flame/sprite.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
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

  final String _assetPath = 'ship.png';
  bool _isFire = false;
  ShipDirection _direction = ShipDirection.none;

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
      _direction = ShipDirection.left;
    } else if (event.logicalKey == LogicalKeyboardKey.arrowRight) {
      _direction = ShipDirection.right;
    }

    if (event is RawKeyUpEvent &&
        event.logicalKey != LogicalKeyboardKey.space) {
      _direction = ShipDirection.none;
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
    if (_direction == ShipDirection.left) {
      position = position - Vector2(50, 0) * dt;
    } else if (_direction == ShipDirection.right) {
      position = position + Vector2(50, 0) * dt;
    }
    super.update(dt);
  }

  @override
  void onGameResize(Vector2 size) {
    super.onGameResize(size);
  }
}

enum ShipDirection { left, right, none }
