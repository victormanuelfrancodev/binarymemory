

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

class NiceEffect extends StatelessWidget {
  const NiceEffect({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 250.0,
        child: DefaultTextStyle(
          style: const TextStyle(
            fontSize: 70.0,
            fontFamily: 'Canterbury',
          ),
          child: AnimatedTextKit(
            animatedTexts: [
              ScaleAnimatedText('Nice'),
            ],
            onTap: () {
            },
          ),
        ),
      ),
    );
  }
}
