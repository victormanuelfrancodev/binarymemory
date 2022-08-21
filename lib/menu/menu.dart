
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:binarymemory/game/binary_memory_game.dart';
import 'package:binarymemory/menu/menu_card.dart';
import 'package:binarymemory/pages/binary_explain.dart';
import 'package:binarymemory/utils/game_colors.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart' hide Image, Gradient;


class Menu extends StatelessWidget {
  const Menu(this.game, {super.key});

  final BinaryMemoryGame game;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Material(
      color: Colors.transparent,
      child: Center(
        child: Wrap(
          children: [
            Column(
              children: [
                MenuCard(
                  children: [
          SizedBox(
          width: 250.0,
          child: DefaultTextStyle(
            style: const TextStyle(
              color: Colors.white,
              fontSize: 19.0,
              fontFamily: 'Lots',
            ),
            child: AnimatedTextKit(
              isRepeatingAnimation: true,
              animatedTexts: [
                TypewriterAnimatedText('Try to memorize the binary'),
                TypewriterAnimatedText('Try to remember it in 10 seconds'),
                TypewriterAnimatedText('Try to use the clues'),
                TypewriterAnimatedText('Try!'),
              ],
              onTap: () {
                print("Tap Event");
              },
            ),
          ),
        ),

                    const SizedBox(height: 10),
                    ElevatedButton(style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                        textStyle:const  TextStyle(
                          color: Colors.black,
                            fontFamily: 'Lots',
                            fontSize: 30,
                            fontWeight: FontWeight.bold)),
                      child:  Text('Play',style: TextStyle(color: Colors.black, fontFamily: 'Lots'),),
                      onPressed: () {
                        game.createNewGame();
                      },
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                        textStyle:const  TextStyle(
                            color: Colors.black,
                            fontFamily: 'Lots',
                            fontSize: 10,
                            fontWeight: FontWeight.bold)),
                      child:  Text('List Binary Code',style: TextStyle(fontSize: 10, color: Colors.black, fontFamily: 'Lots'),),
                      onPressed: () {
                        Navigator.push(
                                 context,
                                 MaterialPageRoute(builder: (context) => const BinaryExplain()),
                               );
                      },
                    ),
                    Text(
                      'ASDW',
                      style: textTheme.bodyText2,
                    ),
                  ],
                ),
                MenuCard(
                  children: [
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'BINARY ',
                            style: textTheme.bodyText2?.copyWith(
                              color: GameColors.white.color,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                          TextSpan(
                            text: 'MEMORY',
                            style: textTheme.bodyText2?.copyWith(
                              color: GameColors.white.color,
                              decoration: TextDecoration.underline,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                final _url =
                                Uri.parse('https://github.com/spydon');
                                //launchUrl(_url);
                              },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}