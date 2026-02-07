import 'package:flutter/material.dart';
// ignore: unnecessary_string_escapes
import 'screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // ... (앱 제목, 테마 설정) ...
      home: const HomeScreen(), // HomeScreen을 여기서 사용합니다.
    );
  }
}