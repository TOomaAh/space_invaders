import 'package:flame/components.dart';
import 'package:fyc/components/monster_component.dart';

/// SpawnComponent is a Component
class SpawnComponent<T> extends PositionComponent with HasGameRef {
  /// SpawnComponent is a Component
  SpawnComponent({
    required this.child,
    required this.nbrChild,
  }) : super(
          position: Vector2(10, 10),
        );

  /// child is the component to spawn
  late final Component child;

  /// nbrChild is the number of child to spawn
  late final int nbrChild;

  @override
  void onLoad() {
    size = Vector2(gameRef.size.x - 20, gameRef.size.y * 0.5);
    for (var i = 0; i < nbrChild; i++) {
      _generateChild();
    }
  }

  void _generateChild(Vector2 position) {
    // create a new monster without clone method
    final newChild = SpriteComponent(
      position: position,
    ) as T;
  }
}
