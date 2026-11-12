import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold
      (body: Center
      (child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'My first flutter app for mobile programming class',
            style: TextStyle(fontSize: 24),
          ),
          SizedBox(height: 16),
          Text(
            'Welcome to my Flutter app.',
            style: TextStyle(fontSize: 18),
          ),
        ],
        
      )),
      )
    );
  }
}
