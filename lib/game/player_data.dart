import 'package:flutter/material.dart';

/// Player data
class PlayerData {
  /// final score
  final score = ValueNotifier<int>(0);

  /// health
  final health = ValueNotifier<int>(100);
}
