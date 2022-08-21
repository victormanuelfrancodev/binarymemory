import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BinaryExplain extends StatelessWidget {
  const BinaryExplain({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Learn how read the binary code', style: TextStyle(fontFamily: 'Arial'),),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: (){
            Navigator.of(context).pop();
          },
        ),
      ),
      body:ListView.builder(
        itemCount: 1000,
        itemBuilder:
          (BuildContext context, int index) {
        return Container(
          height: 80,
          child: Text('Decimal: $index Binario: ${index.toRadixString(2)}',style: TextStyle(fontFamily: 'Arial'),),
        );
      },
      )
    );
  }
}
