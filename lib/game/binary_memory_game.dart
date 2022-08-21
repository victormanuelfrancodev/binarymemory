import 'dart:math';
import 'package:binarymemory/clock/clock_text.dart';
import 'package:binarymemory/clock/counter.dart';
import 'package:binarymemory/game/binary_button.dart';
import 'package:binarymemory/game/heart.dart';
import 'package:binarymemory/game/skull.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/game.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';

import 'message.dart';

enum StateGame{
  playing,
  notPlaying,
}

class BinaryMemoryGame extends FlameGame with HasTappables {
  int level = 1;
  String questions = "";
  String hiddenText = "";
  late ClockText clockText;
  late TextComponent scoreTextComponent;
  late TextComponent decimalNumberTextComponent;
  String decimalNumberText = "";
  int lives = 3;
  int points = 0;
  String binaryWinner = "";
  StateGame stateGame = StateGame.notPlaying;
  static ButtonState buttonState = ButtonState.disable;
  List<Heart> lifeList = [];
  List<BinaryButton> binaryButtonList = [];

  late TextComponent textQuestionComponent;

  late TextComponent textClue;

  @override
  Future<void>? onLoad() {
    FlameAudio.loop('gameintroo.mp3',volume:0.5);
    addComponents();
    return super.onLoad();
  }
  //From game over restart game
  void restartGame(){
    overlays.remove('gameover');
    stateGame = StateGame.notPlaying;
    lives = 3;
    points = 0;
    level = 1;
    questions ="";
    hiddenText = "";
    binaryWinner = "";
    addComponents();
    generateLife();
    settingClock(ClockType.memorize);
    generateQuestion();
    buttonState = ButtonState.disable;

  }

  void startCounter(){
    Counter counter = Counter(3);
    add(counter);
  }

  void addClockDecoder(){
    settingClock(ClockType.decode);
  }
  ///Hidden binary , hidden the binary when the counter timer finished
  void hiddenBinary(){
    stateGame = StateGame.playing;
    /// disable touch mouse
    buttonState = ButtonState.enable;
    /// hidden the password
    textQuestionComponent.text = hiddenText;
    ///Appear buttons
    binaryButtonList[0].appear();
    binaryButtonList[1].appear();
  }

  void generateQuestion() {
    for (var i = 0; i < level; i++) {
      final binary = Random().nextInt(2);
      questions += binary.toString();
      hiddenText += '*';
    }
    binaryWinner = questions;
    updateTextComponent();
    updateDecimalNumberTextComponent();
  }

  void addComponents() {

    final small =
    TextPaint(style: const TextStyle(fontFamily: 'Lots',fontSize: 09, color: Colors.white));

    final regular =
        TextPaint(style: const TextStyle(fontFamily: 'Lots',fontSize: 23, color: Colors.white));

    scoreTextComponent = TextComponent(
        text: points.toString(),
        textRenderer: regular,
        anchor: Anchor.center,
        position: Vector2(size.x -50, 90));

    textQuestionComponent = TextComponent(
        text: questions,
        textRenderer: regular,
        anchor: Anchor.center,
        position: Vector2(size.x / 2, size.y / 2));

    decimalNumberTextComponent =TextComponent(
        text: decimalNumberText,
        textRenderer: small,
        anchor: Anchor.center,
        position: Vector2(size.x / 2, size.y/2 - 30));

    add(scoreTextComponent);
    add(textQuestionComponent);
    add(decimalNumberTextComponent);

    binaryButtonList.add(BinaryButton('0', Vector2((size.x / 2) - 90, size.y / 2 + 80)));
    binaryButtonList.add(BinaryButton('1', Vector2((size.x / 2) + 30, size.y / 2 + 80)));

    add(binaryButtonList[0]);
    add(binaryButtonList[1]);
    binaryButtonList[0].dissapear();
    binaryButtonList[1].dissapear();
    ///add hub to the game
    if(!overlays.isActive('helper')){
      overlays.add('helper');
    }
  }

  void createNewGame() {
    overlays.remove('menu');
    settingClock(ClockType.memorize);
    generateQuestion();
    generateLife();
  }

  void generateLife(){
    for(int i=0; i<lives; i++){
      var heart = Heart();
      heart.position = Vector2((i * 30)+10,120);
      lifeList.add(heart);
      add(lifeList[i]);
    }
  }

  void settingClock(ClockType clockType) {
    if(clockType == ClockType.memorize){
      clockText = ClockText(Vector2(10, 10), 3,ClockType.memorize);
    }else{
      clockText = ClockText(Vector2(10, 10), 10,ClockType.decode);
    }
    add(clockText);
  }

  createNewSet() {
    questions = "";
    hiddenText = "";
    generateQuestion();
    updateTextComponent();
    remove(clockText);
    settingClock(ClockType.memorize);
  }

  void deleteCharacterFromQuestion() {
    questions = questions.substring(1);
    hiddenText = hiddenText.substring(1);
    hiddenBinary();
  }

  void updateTextComponent() {
    textQuestionComponent.text = questions;
  }

  void updatePointsTextComponent(){
    scoreTextComponent.text = points.toString();
  }

  void updateDecimalNumberTextComponent(){
    int decimalNumber1 = int.parse(questions, radix: 2);
    decimalNumberTextComponent.text = 'Decimal Clue: ${decimalNumber1.toString()}';
  }


  ///Game Over
  ///
  void isGameOver(bool isHit)async{
    if(isHit){
      FlameAudio.play('nice.mp3',volume: 1);
      points +=1;
      if(level<=11){
        level +=1;
      }
      scoreTextComponent.text = points.toString();
      ///Delay generate new game
      add(Message(''
          'Nice \n Creating new code..')..position = Vector2(size.x/2, size.y/2));
      await Future.delayed(const Duration(seconds: 2));

      createNewSet();
    }else{
      FlameAudio.play('error.mp3',volume: 1);
      lives -=1;
      ///Add Skull
      add(Skull()..position = Vector2(size.x/2, size.y/2));
      camera.shake(duration: 0.8, intensity: 6.0);
      if(lives == 0){
        gameOver();
      }else{
        //generate new set game
        if(level >1){
          level -= 1;
        }
        removeLife();
        add(Message(''
            'bad but Wait.. \nCreating new code..')..position = Vector2(size.x/2, size.y/2));
        createNewSet();
      }
    }
    stateGame = StateGame.notPlaying;
    ///Disappear buttons
    binaryButtonList[0].dissapear();
    binaryButtonList[1].dissapear();
  }

  void removeLife(){
    lifeList[lives].removeFromParent();
  }

  void gameOver(){
    buttonState = ButtonState.disable;
    clockText.stopClock();
    clockText.removeFromParent();
    for (var element in children) {
      element.removeFromParent();
    }
    overlays.add('gameover');
    overlays.remove('helper');
  }

  void generateTip(){
    if(stateGame == StateGame.playing){
      if(points >= 2){
        points -= 2;
        generateCluesAnimation();
        updatePointsTextComponent();
      }else{
        //print(' no tienes suficientes puntos para un tip');
      }
    }
  }

  void generateCluesAnimation(){
    for(var animation = 0; animation< 10;animation++){
      addTextClue();
    }
  }

  void addTextClue(){
    final regular = TextPaint(style: const TextStyle(fontSize: 23, color: Colors.white, fontFamily: 'Lots'));
    var randomHeight = Random().nextInt(size.y.toInt());
    textClue = TextComponent(text: binaryWinner, textRenderer:regular, position: Vector2(size.x + 100, 100));
    var effectController = EffectController(duration: 3.5);
    randomHeight = Random().nextInt(size.y.toInt());
    var moveEffect = MoveEffect.to(Vector2( - textClue.size.x - 15 ,randomHeight.toDouble()), effectController)..onComplete = (){
      textClue.removeFromParent();
    };
    add(textClue);
    textClue.add(moveEffect);
  }

}
