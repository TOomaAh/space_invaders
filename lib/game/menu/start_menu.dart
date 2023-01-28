import 'package:flame/components.dart';
import 'package:flutter/rendering.dart';
import 'package:fyc/game/invaders.dart';
import 'package:fyc/ui/rounded_button.dart';

class StartMenu extends Component with HasGameRef<InvadersGame> {
  /// StartMenu is a Component
  StartMenu() {
    addAll([
      _logo = TextComponent(
        text: 'Space Invaders',
        textRenderer: TextPaint(
          style: const TextStyle(
            fontSize: 64,
            color: Color(0xFFC8FFF5),
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
      _start_button = RoundedButton(
        text: 'Start',
        action: () => gameRef.router.pushNamed('start'),
        color: const Color(0xffadde6c),
        borderColor: const Color(0xffedffab),
      ),
      _leave_button = RoundedButton(
        text: 'Leave',
        action: () => gameRef.router.pushNamed('leave'),
        color: const Color(0xffadde6c),
        borderColor: const Color(0xffedffab),
      ),
    ]);
  }

  late final TextComponent _logo;
  late final RoundedButton _start_button;
  late final RoundedButton _leave_button;

  @override
  void onGameResize(Vector2 size) {
    super.onGameResize(size);
    //center the logo on the screen
    _logo.position = Vector2((size.x / 2) - (_logo.size.x / 2), size.y / 4);
    _start_button.position = Vector2(size.x / 2, _logo.y + 140);
    _leave_button.position = Vector2(size.x / 2, _start_button.y + 80);
  }
}
