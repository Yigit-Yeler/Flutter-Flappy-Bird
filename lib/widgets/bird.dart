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
        child: Stack(
          children: [
            Image.asset(
              GameConstants.birdSprite,
              width: GameConstants.birdWidth,
              height: GameConstants.birdHeight,
              fit: BoxFit.fill,
            ),
            if (debugMode) // Debug modu için hitbox gösterimi
              Container(
                width: GameConstants.birdWidth,
                height:
                    GameConstants.birdHeight * 0.8, // Hitbox'ı %80 yükseklikte
                margin: const EdgeInsets.only(
                    top:
                        GameConstants.birdHeight * 0.1), // Yukarıdan %10 boşluk
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.red, width: 2),
                  color: Colors.red.withOpacity(0.2),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
