class GameConstants {
  // Ekran boyutları
  static const double gameSpeed = 1.0;

  // Kuş özellikleri
  static const double birdWidth = 50.0;
  static const double birdHeight = 40.0;
  static const double birdX = 50.0;
  static const double gravity = 0.25;
  static const double jumpForce = -6.5;
  static const double maxVelocity = 15.0;

  // Borular
  static const double pipeWidth = 52.0;
  static const double pipeGap = 180.0;
  static const double pipeSpeed = 2.5;
  static const double minPipeDistance = 250.0;
  static const double minPipeY = 100.0;
  static const double maxPipeY = 280.0;
  static const double pipeHeight = 320.0;

  // Zemin
  static const double groundHeight = 100.0;

  // Oyun durumları
  static const int fps = 60;
  static const double initialBirdY = 300;
  static const Duration gameTickTime = Duration(milliseconds: 1000 ~/ fps);

  // Görsel dosyaları
  static const String birdSprite = 'assets/sprites/yellowbird-midflap.png';
  static const String pipeSprite = 'assets/sprites/pipe-green.png';
  static const String backgroundSprite = 'assets/sprites/background-day.png';
  static const String groundSprite = 'assets/sprites/base.png';
}
