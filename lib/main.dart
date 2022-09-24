import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/experimental.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'game/invaders.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final game = InvadersGame();

  runApp(
    MyGame(
      game: game,
    ),
  );
}

class MyGame extends StatelessWidget {
  // ignore: public_member_api_docs
  MyGame({required InvadersGame game, super.key}) {
    _game = game;
  }

  late InvadersGame _game;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, //remove debug banner,
      title: 'Space Invaders',
      theme: ThemeData.dark(),
      home: Scaffold(
        body: GameWidget<InvadersGame>(
          game: kDebugMode ? InvadersGame() : _game,
        ),
      ),
    );
  }
}
