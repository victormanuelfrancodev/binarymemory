import 'dart:ui';

import 'package:binarymemory/game/binary_memory_game.dart';
import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flutter/material.dart';


class Counter extends PositionComponent with HasGameRef<BinaryMemoryGame>{
  late Timer _timer;
  //animation change each 1 second
  double animationTime = 0.765;

  int _counter =0;
  late List<Image> imageList = [];
  late int _timeLong = 0;

  Counter(this._timeLong){

    _timer = Timer(animationTime);
    _timer.start();
  }

  final TextPaint textConfig = TextPaint(
    style: const TextStyle(fontFamily: 'Lots',color: Colors.white, fontSize: 68),
  );

  @override
  Future<void>? onLoad() {
    changePriorityWithoutResorting(21);
    return super.onLoad();
  }

  @override
  void render(Canvas canvas) {
    //Select which image show on 0sec ,1 sec, 2 sec, 3 sec
    switch(_counter){
      case 0:
        textConfig.render(
          canvas,
          '3',
          Vector2((gameRef.size.x / 2 ) -25 ,gameRef.size.y /2 +25),
        );
        break;
      case 1:
        textConfig.render(
          canvas,
          '2',
          Vector2((gameRef.size.x / 2 )-25 ,gameRef.size.y /2 +25),
        ); break;
      case 2:
        textConfig.render(
          canvas,
          '1',
          Vector2((gameRef.size.x / 2 ) -25,gameRef.size.y /2 +25),
        ); break;
      case 3:
        textConfig.render(
          canvas,
          'GO!',
          Vector2((gameRef.size.x / 2 )  -25,gameRef.size.y /2 -15),
        ); break;
    }
    super.render(canvas);
  }

  @override
  void update(double dt) {
    //If counter > 3 , remove the counter and send trigger for start game
    _timer.update(dt);
    if(_timer.finished){
      _timer.stop();
      if (_counter == (_timeLong - 3)) {
        _counter +=1;
        _timer.start();

      } else if (_counter < (_timeLong - 1)) {
        _counter += 1;
        _timer.start();
      } else {
        removeFromParent();
        _runningGame();
      }
    }
    super.update(dt);
  }

  ///The user can interactive with the game
  _runningGame() async {
    gameRef.addClockDecoder();
    gameRef.hiddenBinary();
  }
}
