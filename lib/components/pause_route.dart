import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/experimental.dart';
import 'package:flame/game.dart';
import 'package:flame/rendering.dart';
import 'package:flutter/rendering.dart';
import 'package:fyc/components/pause_component.dart';

/// PauseButton is a Route
/*class PauseRoute extends Route {
  /// Pause route
  PauseRoute() : super(PauseComponent.new, transparent: true);

  @override
  void onPush(Route? previousRoute) {
    previousRoute!
      ..stopTime()
      ..addRenderEffect(
        PaintDecorator.grayscale(opacity: 0.5)..addBlur(3.0),
      );
  }

  @override
  void onPop(Route previousRoute) {
    previousRoute
      ..resumeTime()
      ..removeRenderEffect();
  }
}*/
