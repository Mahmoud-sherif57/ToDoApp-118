import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class AnimationScreen extends StatelessWidget {
  const AnimationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Lottie.network('https://lottie.host/44da6b0c-48de-4a55-bccb-951c28bf013b/vVoUPnL4V6.json',)
        ],
      ),
    );
  }
}
