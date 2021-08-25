import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

void main() => runApp(LoadingPage());

class LoadingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: ListView(
          children: [
            // Load a Lottie file from your assets
            Lottie.asset('assets/loading.json'),
          ],
        ),
      ),
    );
  }
}
