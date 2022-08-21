import 'dart:io';

import 'package:binarymemory/game/binary_memory_game.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class Message extends PositionComponent with HasGameRef<BinaryMemoryGame> {
  String message;
  late Timer _timer;
  late TextComponent messageTextComponent;
  double animationTime = 2.0;

  Message(this.message);

  @override
  Future<void>? onLoad() {
    var fontSize = 68.0;
    try {
      if (Platform.isAndroid || Platform.isIOS) {
        //  kisweb=false;
        fontSize = 8.0;
      } else {
        // kisweb=true;
      }
    } catch (e) {
      // kisweb=true;
    }

    final TextPaint textConfig = TextPaint(
      style: TextStyle(
          fontFamily: 'Lots', color: Colors.white, fontSize: fontSize),
    );
    messageTextComponent = TextComponent(
      text: message,
      textRenderer: textConfig,
      anchor: Anchor.center,
    );

    add(messageTextComponent);

    _timer = Timer(animationTime);
    _timer.start();
    anchor = Anchor.center;

    return super.onLoad();
  }

  @override
  void update(double dt) {
    _timer.update(dt);
    if (_timer.finished) {
      _timer.stop();
      removeFromParent();
    }
    super.update(dt);
  }
}
