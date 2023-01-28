import 'package:flame/components.dart';
import 'package:fyc/game/invaders.dart';

abstract class Level {
  /// getComponent Return a list of components
  /// return a list of components for each line
  List<List<Component>> getComponent();

  /// gameIsFinished Return true if all monsters are dead
  /// return true if all monsters are dead
  /// return false if all monsters are not dead
  bool gameIsFinished(InvadersGame gameRef);
}
