import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

import '../constants/game_constants.dart';
import '../services/asset_manager.dart';
import 'bird.dart';
import 'pipe.dart';

class GameWidget extends StatefulWidget {
  const GameWidget({super.key});

  @override
  GameWidgetState createState() => GameWidgetState();
}

class GameWidgetState extends State<GameWidget> {
  double birdY = GameConstants.initialBirdY;
  double velocity = 0;
  double rotation = 0;
  bool gameStarted = false;
  bool gameOver = false;
  List<double> pipesX = [];
  List<double> pipesY = [];
  Timer? gameTimer;
  int score = 0;
  int highScore = 0;
  bool debugMode = true;

  @override
  void initState() {
    super.initState();
    AssetManager.preloadAssets();
  }

  void startGame() {
    gameStarted = true;
    gameOver = false;
    score = 0;
    birdY = GameConstants.initialBirdY;
    velocity = 0;
    rotation = 0;
    pipesX.clear();
    pipesY.clear();

    gameTimer = Timer.periodic(GameConstants.gameTickTime, (timer) {
      updateGame();
    });
  }

  void updateGame() {
    setState(() {
      // Kuş fiziği
      velocity += GameConstants.gravity;
      velocity =
          velocity.clamp(-GameConstants.maxVelocity, GameConstants.maxVelocity);
      birdY += velocity;

      // Kuş rotasyonu
      rotation = (velocity * 0.2).clamp(-0.5, 0.5);

      // Boruları hareket ettir
      for (int i = 0; i < pipesX.length; i++) {
        pipesX[i] -= GameConstants.pipeSpeed;
      }

      // Yeni borular ekle
      if (pipesX.isEmpty ||
          pipesX.last <
              MediaQuery.of(context).size.width -
                  GameConstants.minPipeDistance) {
        pipesX.add(MediaQuery.of(context).size.width);

        // Boruların konumunu ayarla
        final maxPipeY = MediaQuery.of(context).size.height -
            GameConstants.groundHeight -
            GameConstants.pipeGap -
            GameConstants.pipeHeight; // Alt borunun maksimum yüksekliği

        final minY = maxPipeY * 0.1; // Alt sınır
        final maxY = maxPipeY * 0.6; // Üst sınır

        pipesY.add(minY + Random().nextDouble() * (maxY - minY));
      }

      // Eski boruları kaldır ve skor ekle
      while (pipesX.isNotEmpty && pipesX[0] < -GameConstants.pipeWidth) {
        pipesX.removeAt(0);
        pipesY.removeAt(0);
        score++;
        AssetManager.playPointSound();
        if (score > highScore) {
          highScore = score;
        }
      }

      checkCollision();
    });
  }

  void jump() {
    if (!gameOver) {
      setState(() {
        velocity = GameConstants.jumpForce;
        AssetManager.playJumpSound();
      });
    }
  }

  void checkCollision() {
    final size = MediaQuery.of(context).size;

    // Yer ve tavan kontrolü
    if (birdY < 0 || birdY > size.height - GameConstants.groundHeight) {
      gameOver = true;
      gameTimer?.cancel();
      return;
    }

    // Boru çarpışma kontrolü
    for (int i = 0; i < pipesX.length; i++) {
      // Yatay çarpışma kontrolü
      if (GameConstants.birdX + GameConstants.birdWidth > pipesX[i] &&
          GameConstants.birdX < pipesX[i] + GameConstants.pipeWidth) {
        // Dikey çarpışma kontrolü
        if (birdY < pipesY[i] || // Üst boruya çarpma
            birdY + GameConstants.birdHeight >
                pipesY[i] + GameConstants.pipeGap) {
          // Alt boruya çarpma
          gameOver = true;
          gameTimer?.cancel();
          return;
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTapDown: (_) {
        if (!gameStarted || gameOver) {
          startGame();
        } else {
          jump();
        }
      },
      child: Stack(
        children: [
          // Arkaplan
          Image.asset(
            GameConstants.backgroundSprite,
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ),
          // Zemin
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Image.asset(
              GameConstants.groundSprite,
              height: GameConstants.groundHeight,
              fit: BoxFit.fill,
            ),
          ),
          // Borular
          ...pipesX.asMap().entries.map((entry) {
            return Pipe(
              pipeX: entry.value,
              pipeY: pipesY[entry.key],
            );
          }),
          // Kuş
          Bird(birdY: birdY, rotation: rotation, debugMode: debugMode),
          // Skor
          Positioned(
            top: 50,
            left: 0,
            right: 0,
            child: Center(
              child: Text(
                score.toString(),
                style: const TextStyle(
                  fontSize: 70,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          if (!gameStarted)
            const Center(
              child: Text(
                'Başlamak için dokun',
                style: TextStyle(fontSize: 30, color: Colors.white),
              ),
            ),
          if (gameOver)
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Oyun Bitti\nSkor: $score\nEn Yüksek Skor: $highScore',
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 30, color: Colors.white),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Tekrar başlamak için dokun',
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ],
              ),
            ),
          if (debugMode) ...[
            // Boruların hitbox'ları
            ...pipesX.asMap().entries.map((entry) {
              final i = entry.key;
              final pipeX = entry.value;
              final topPipeBottom = pipesY[i] + GameConstants.pipeHeight;
              final bottomPipeTop = topPipeBottom + GameConstants.pipeGap;

              return Stack(
                children: [
                  // Üst boru hitbox'ı
                  Positioned(
                    left: pipeX,
                    top: 0,
                    child: Container(
                      width: GameConstants.pipeWidth,
                      height: pipesY[i],
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.blue, width: 2),
                        color: Colors.blue.withOpacity(0.2),
                      ),
                    ),
                  ),
                  // Alt boru hitbox'ı
                  Positioned(
                    left: pipeX,
                    top: pipesY[i] + GameConstants.pipeGap,
                    child: Container(
                      width: GameConstants.pipeWidth,
                      height: MediaQuery.of(context).size.height -
                          pipesY[i] -
                          GameConstants.pipeGap -
                          GameConstants.groundHeight,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.blue, width: 2),
                        color: Colors.blue.withOpacity(0.2),
                      ),
                    ),
                  ),
                ],
              );
            }),
          ],
        ],
      ),
    );
  }
}
