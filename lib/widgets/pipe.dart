import 'package:flutter/material.dart';

import '../constants/game_constants.dart';

class Pipe extends StatelessWidget {
  final double pipeX;
  final double pipeY;

  const Pipe({super.key, required this.pipeX, required this.pipeY});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      alignment: Alignment(
        pipeX / (size.width / 2) - 1,
        0,
      ),
      child: Column(
        children: [
          // Üst boru
          Transform.rotate(
            angle: 3.14159,
            child: Image.asset(
              GameConstants.pipeSprite,
              width: GameConstants.pipeWidth,
              height: pipeY,
              fit: BoxFit.fill,
            ),
          ),
          const SizedBox(height: GameConstants.pipeGap),
          // Alt boru
          Image.asset(
            GameConstants.pipeSprite,
            width: GameConstants.pipeWidth,
            height: size.height -
                pipeY -
                GameConstants.pipeGap -
                GameConstants.groundHeight,
            fit: BoxFit.fill,
          ),
        ],
      ),
    );
  }
}
