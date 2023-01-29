import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/experimental.dart';
import 'package:flame/game.dart';
import 'package:flame/rendering.dart';
import 'package:flutter/rendering.dart';
import 'package:fyc/components/game_component.dart';
import 'package:fyc/components/spawn_component.dart';
import 'package:fyc/game/invaders.dart';
import 'package:fyc/game/player_data.dart';

abstract class SimpleButton extends PositionComponent with TapCallbacks {
  SimpleButton(this._iconPath, {super.position}) : super(size: Vector2.all(40));

  final Paint _borderPaint = Paint()
    ..style = PaintingStyle.stroke
    ..color = const Color(0x66ffffff);
  final Paint _iconPaint = Paint()
    ..style = PaintingStyle.stroke
    ..color = const Color(0xffaaaaaa)
    ..strokeWidth = 7;
  final Path _iconPath;

  void action();

  @override
  void render(Canvas canvas) {
    canvas.drawRRect(
      RRect.fromRectAndRadius(size.toRect(), const Radius.circular(8)),
      _borderPaint,
    );
    canvas.drawPath(_iconPath, _iconPaint);
  }

  @override
  void onTapDown(TapDownEvent event) {
    _iconPaint.color = const Color(0xffffffff);
  }

  @override
  void onTapUp(TapUpEvent event) {
    _iconPaint.color = const Color(0xffaaaaaa);
    action();
  }

  @override
  void onTapCancel(TapCancelEvent event) {
    _iconPaint.color = const Color(0xffaaaaaa);
  }
}

/// SimpleButton is a PositionComponent
class BackButtonCustom extends SimpleButton with HasGameRef<InvadersGame> {
  /// BackButton is a SimpleButton
  BackButtonCustom({required this.gameComponent})
      : super(
          Path()
            ..moveTo(22, 8)
            ..lineTo(10, 20)
            ..lineTo(22, 32)
            ..moveTo(12, 20)
            ..lineTo(34, 20),
          position: Vector2.all(10),
        );

  final GameComponent gameComponent;

  @override
  void action() {
    gameComponent
      ..removeAll(gameComponent.children.whereType<SpawnComponent>())
      ..add(SpawnComponent(level: gameComponent.levels[0]));
    gameRef.overlays.remove('pause');
    gameRef.overlays.remove('score');
    gameRef.router.pop();
  }
}
