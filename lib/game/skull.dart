

import 'package:binarymemory/game/binary_memory_game.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class Skull extends SpriteComponent with HasGameRef<BinaryMemoryGame>{
  late Timer _timer;
  double animationTime = 1.5;

  @override
  Future<void>? onLoad() async{

    sprite = Sprite(await gameRef.images.load('skull.png'));
    size = Vector2(86, 86);
    _timer = Timer(animationTime);
    _timer.start();
    anchor = Anchor.center;
    return super.onLoad();
  }

  @override
  void update(double dt) {
    _timer.update(dt);
    if(_timer.finished){
      _timer.stop();
      removeFromParent();
    }
    super.update(dt);
  }

  @override
  void render(Canvas canvas) {

    super.render(canvas);
  }

}