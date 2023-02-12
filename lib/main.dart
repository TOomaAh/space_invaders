import 'dart:async';
import 'package:flame/game.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flame_splash_screen/flame_splash_screen.dart';
import 'package:fyc/game/invaders.dart';
import 'package:fyc/game/splashscreen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MyGame(),
  );
}

/// MyGame is a StatelessWidget
class MyGame extends StatelessWidget {
  // ignore: public_member_api_docs
  MyGame({super.key});

  final InvadersGame _game = InvadersGame();

  @override
  Widget build(BuildContext context) {
    _loadAssets();
    return MaterialApp(
      debugShowCheckedModeBanner: false, //remove debug banner,
      title: 'Space Invaders',
      theme: ThemeData.dark(),
      home: Scaffold(
        body: SplashScreenGame(
          game: _game,
        ),
      ),
    );
  }

  Future<void> _loadAssets() async {
    await _game.images.loadAll([
      'laser.png',
      'player.png',
      'green.png',
      'red.png',
      'yellow.png',
    ]);
  }
}
