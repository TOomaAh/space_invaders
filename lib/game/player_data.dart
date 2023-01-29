import 'package:flutter/material.dart';

/// Player data
class PlayerData {
  /// final score
  final score = ValueNotifier<int>(0);

  /// reset
  void reset() {
    score.value = 0;
  }
}
