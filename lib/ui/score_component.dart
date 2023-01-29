import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:fyc/game/invaders.dart';

class ScoreWidget extends StatefulWidget {
  /// Score widget
  const ScoreWidget({super.key, required this.game});

  final InvadersGame game;

  @override
  State<ScoreWidget> createState() => _ScoreWidgetState();
}

class _ScoreWidgetState extends State<ScoreWidget> {
  @override
  Widget build(BuildContext context) {
    // Score on the top right of the screen
    return Container(
        alignment: Alignment.topRight,
        child: ValueListenableBuilder(
          valueListenable: widget.game.playerData.score,
          builder: (context, int value, child) => Text(
            'Score: $value',
            style: const TextStyle(color: Colors.white, fontSize: 20),
          ),
        ));
  }
}
