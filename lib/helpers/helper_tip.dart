
import 'package:binarymemory/game/binary_memory_game.dart';
import 'package:flutter/material.dart';

class HelperTip extends StatelessWidget {
  const HelperTip(this.game, {super.key});

  final BinaryMemoryGame game;

  @override
  Widget build(BuildContext context) {
    return  Material(
      color: Colors.transparent,
      child:  Container(
        width: MediaQuery.of(context).size.width,
        height: 150,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            InkWell(
              onTap: (){
                game.generateTip();
              },
              child: Container(
                margin: EdgeInsets.only(top: 30),
                width: 100,
                height: 150,
                child: Column(
                  children:  [Icon(Icons.lightbulb, color: Colors.white,),
                    Text(
                    'Clue',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white),
                  ),
                    Container(
                      padding: EdgeInsets.only(top: 5),
                      child: Text(
                        '-2 points',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 6,color: Colors.white),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 30),
              width: 100,
              height: 150,
              child: Column(
                children: [Icon(Icons.account_circle, color: Colors.white,), Text(
                  "Score",
                  style: TextStyle(color: Colors.white),
                )],
              ),
            )
          ],
        ),
      ),
    );
  }
}
