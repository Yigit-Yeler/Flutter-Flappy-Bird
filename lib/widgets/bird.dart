import 'package:flutter/material.dart';

import '../constants/game_constants.dart';

class Bird extends StatelessWidget {
  final double birdY;
  final double rotation;
  final bool debugMode;

  const Bird({
    super.key,
    required this.birdY,
    this.rotation = 0,
    this.debugMode = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment(
        GameConstants.birdX / (MediaQuery.of(context).size.width / 2) - 1,
        birdY / (MediaQuery.of(context).size.height / 2) - 1,
      ),
      child: Transform.rotate(
        angle: rotation,
        child: Image.asset(
          GameConstants.birdSprite,
          width: GameConstants.birdWidth,
          height: GameConstants.birdHeight,
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
