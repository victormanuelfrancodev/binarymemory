import 'package:binarymemory/game/binary_memory_game.dart';
import 'package:binarymemory/menu/menu_card.dart';
import 'package:binarymemory/pages/score_page.dart';
import 'package:built_in_keyboard/built_in_keyboard.dart';
import 'package:built_in_keyboard/language.dart';
import 'package:flutter/material.dart' hide Image, Gradient;
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class GameOver extends StatelessWidget {
  GameOver(this.game, {super.key});

  final BinaryMemoryGame game;


  Future<void> registerScore(String name)async{
    await dotenv.load(fileName: ".env");

    final keyApplicationId = dotenv.env['KEYAPPLICATIONID'];
    final keyClientKey = dotenv.env['KEYCLIENT'];
    final keyParseServerUrl = 'https://parseapi.back4app.com';

    await Parse().initialize(keyApplicationId!, keyParseServerUrl,
        clientKey: keyClientKey, debug: true);

    final score = ParseObject('Score')
      ..set('name', name)
      ..set('score', game.points);
    await score.save();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    TextEditingController textController = new TextEditingController();
    return Material(
      color: Colors.transparent,
      child: Center(
        child: Wrap(
          children: [
            MenuCard(
              children: [
                Text(
                  'Score ${game.points}',
                  style: TextStyle(color: Colors.white, fontSize: 23, fontFamily: 'Lots'),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  maxLines: 2,
                  maxLength: 5,
                  controller: textController,
                  readOnly: true,
                  decoration: InputDecoration(
                    labelText: textController.value.text,
                      filled: true,
                      fillColor: Colors.white,
                   hintText: 'Name',
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 3),
                  child: BuiltInKeyboard(
                    language: Language.EN,
                    layout: Layout.QWERTY,
                    borderRadius: BorderRadius.circular(8),
                    controller: textController,
                    enableLongPressUppercase: true,
                    enableSpaceBar: true,
                    enableBackSpace: true,
                    enableCapsLock: true,
                  ),
                ),
                ElevatedButton(
                  onPressed: () async{
                    await registerScore(textController.value.text);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ScorePage(game),
                      ),
                    );
                  },
                  child: const Text('Send Score'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}