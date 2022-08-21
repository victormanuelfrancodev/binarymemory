import 'package:binarymemory/game/binary_memory_game.dart';
import 'package:binarymemory/gameover/game_over.dart';
import 'package:binarymemory/helpers/helper_tip.dart';
import 'package:binarymemory/menu/menu.dart';
import 'package:binarymemory/nice/nice_effect.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

void main() async{

  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = ThemeData(
      fontFamily: 'Lots'
    );

    return MaterialApp(
      theme: theme,
      home:  GameWidget<BinaryMemoryGame>(
        game: BinaryMemoryGame(),
        loadingBuilder: (context) => Center(
          child: Text(
            'Loading...',
            style: Theme.of(context).textTheme.headline1,
          ),
        ),
        overlayBuilderMap: {
          'menu':(_,game) => Menu(game),
          'nice':(_,game) => const NiceEffect(),
          'gameover':(_,game)=> GameOver(game),
          'helper': (_,game)=> HelperTip(game),
        },
        initialActiveOverlays: const ['menu'],
      ),
    );
  }


}

