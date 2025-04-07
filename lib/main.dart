import 'package:flutter/material.dart';
import 'screens/water_source_selection_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Water Quality Detector',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const WaterSourceSelectionScreen(),
    );
  }
}