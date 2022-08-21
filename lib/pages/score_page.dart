import 'dart:convert';

import 'package:binarymemory/game/binary_memory_game.dart';
import 'package:binarymemory/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

import '../model/score.dart';

class ScorePage extends StatefulWidget {
  BinaryMemoryGame game;
  ScorePage(this.game);

  @override
  State<ScorePage> createState() => _ScorePageState();
}

class _ScorePageState extends State<ScorePage> {

  Future<List<dynamic>?> getTopScore()async{
    await dotenv.load(fileName: ".env");

    final keyApplicationId = dotenv.env['KEYAPPLICATIONID'];
    final keyClientKey = dotenv.env['KEYCLIENT'];
    final keyParseServerUrl = 'https://parseapi.back4app.com';


    await Parse().initialize(keyApplicationId!, keyParseServerUrl,
        clientKey: keyClientKey, debug: true);

    QueryBuilder<ParseObject> queryScore =
    QueryBuilder<ParseObject>(ParseObject('Score'));
    queryScore.orderByDescending('score');
    final ParseResponse apiResponse = await queryScore.query();

    if (apiResponse.success && apiResponse.results != null) {
      // Let's show the results
      return apiResponse.results;

    }else{
      return [];
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Column(
          children: [
            Center(child: Container(
                margin: EdgeInsets.all(35),
                child: Text('Top Scores', style: TextStyle(color: Colors.white),)),),
            Expanded(
              child: FutureBuilder(
                future: getTopScore(),
                builder: (BuildContext context, AsyncSnapshot<List<dynamic>?> snapshot) {
                  if( snapshot.hasData){
                    var scoreData = snapshot.data!;
                    //return MedicalRecordsModel.fromJson(jsonDecode(response.body)[0]);
                    return ListView.builder(
                      itemCount: scoreData.length,
                      itemBuilder: (BuildContext context, int index){
                        var item = Score.fromJson(jsonEncode(scoreData[index]));
                        return Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                                padding:EdgeInsets.all(25),
                                child: Text('${item.name}',style: TextStyle(color: Colors.white, fontSize: 23, fontFamily: 'Lots'))),
                            Text('${item.score}',style: TextStyle(color: Colors.white,fontSize: 23,fontFamily: 'Lots')),
                          ],
                        );
                      },);
                  }else{
                    return Container(color: Colors.red,);
                  }
                },
              ),
            ),
            Container(
              margin: EdgeInsets.all(75),
              child: ElevatedButton(
                onPressed: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MyApp(),
                    ),
                  );
                },
                child: const Text('Restart'),
              ),
            )
          ],
        ),
    );
  }
}
