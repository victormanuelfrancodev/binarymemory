
import 'package:binarymemory/game/binary_memory_game.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';

enum ButtonState{
  enable,
  disable
}

class BinaryButton extends PositionComponent with HasGameRef<BinaryMemoryGame>,Tappable{

  String binary;
  Vector2 positionButton;

  BinaryButton(this.binary, this.positionButton);

  @override
  Future<void>? onLoad() {
    size = Vector2(60,60);
    position = positionButton;
    ///Add text insideButton
    final regular = TextPaint(style: const TextStyle(fontFamily: 'Lots',fontSize:23,color: Colors.black));
    var textQuestionComponent = TextComponent(
        text: binary,
        textRenderer: regular,
        anchor: Anchor.center,
        position: Vector2(size.x / 2, size.y / 2));

    add(textQuestionComponent);
    return super.onLoad();
  }

  @override
  bool onTapUp(_) {
    if(gameRef.stateGame == StateGame.playing){

      if(BinaryMemoryGame.buttonState == ButtonState.enable){
        FlameAudio.play('key.mp3',volume: 1);
        if(gameRef.questions.startsWith(binary)){
          if(gameRef.questions.length == 1){
            gameRef.isGameOver(true);
          }else{
            gameRef.deleteCharacterFromQuestion();
          }
        }else{
          gameRef.isGameOver(false);
        }
      }
    }
    return true;
  }

  @override
  void render(Canvas canvas) {
    canvas.drawOval(const Rect.fromLTWH(0, 0, 60, 60), Paint()..color = Colors.white);
    super.render(canvas);
  }

  void dissapear(){
    var controllerEffect = EffectController(duration: 0.5);
    var moveEffect = MoveEffect.to(Vector2(position.x,gameRef.size.y + 100), controllerEffect);
    add(moveEffect);
  }

  void appear(){
    var controllerEffect = EffectController(duration: 0.5);
    var moveEffect = MoveEffect.to(Vector2(position.x,gameRef.size.y / 2 + 80), controllerEffect);
    add(moveEffect);
  }

}