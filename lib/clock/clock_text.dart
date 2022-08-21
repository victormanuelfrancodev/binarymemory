
import 'package:binarymemory/game/binary_memory_game.dart';
import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flutter/material.dart';
import 'dart:io' show Platform;


enum ClockType {
 memorize,
 decode
}
///Clock Text
class ClockText extends PositionComponent with HasGameRef<BinaryMemoryGame>{

  ClockText(this._position, this.time, this.clockType);
  late Timer countdown;
  late double time;
  ClockType clockType;
  late String textMessage;
  late TextPaint textConfig;

  final Vector2 _position;
  late double _elapsedSecs;

  @override
  Future<void>? onLoad() {
    var fontSize = 18.0;

    try{
      if(Platform.isAndroid||Platform.isIOS) {
      //  kisweb=false;
        fontSize = 8.0;
      } else {
       // kisweb=true;
      }
    } catch(e){
     // kisweb=true;
    }

    textConfig =  TextPaint(
      style: TextStyle(fontFamily: 'Lots',color: Colors.white, fontSize: fontSize),
    );
    _elapsedSecs = time;
    countdown = Timer(1 , onTick: () => _elapsedSecs -= 1, repeat: true);
   textMessage = clockType == ClockType.memorize ? "Time to Memorize":"Time Decode";
    return super.onLoad();
  }

  void startClock(){
    countdown.start();
  }

  void stopClock(){
    countdown.stop();
  }


  void pauseClock(){
    countdown.pause();
  }

  void resumeClock(){
    countdown.resume();
  }

  @override
  void update(double dt) {
    if(_elapsedSecs <= 0){
      countdown.stop();
      endTime();
    }else{
      countdown.update(dt);
    }
    super.update(dt);
  }

  void endTime(){
    if(clockType == ClockType.decode){
      removeFromParent();
      gameRef.isGameOver(false);
    }else{
      removeFromParent();
      gameRef.startCounter();
    }
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    textConfig.render(
      canvas,
      '$textMessage \n \n 00:00:${_elapsedSecs< 10? "0${_elapsedSecs.toInt()}":
      _elapsedSecs.toInt()}',
      Vector2((_position.x / 2 )  ,_position.y + 30  ),
    );

  }
}
