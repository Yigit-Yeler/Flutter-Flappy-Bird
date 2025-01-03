import 'package:flutter/material.dart';

import '../widgets/game_widget.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: Container(
          color: Colors.black,
          child: const GameWidget(),
        ),
      ),
    );
  }
}
