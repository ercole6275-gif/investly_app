
import 'package:flutter/material.dart';

void main() => runApp(const App());

class App extends StatelessWidget {
  const App({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text("Investly Demo")),
        body: const Center(child: Text("Investly Flutter Project Ready")),
      ),
    );
  }
}
