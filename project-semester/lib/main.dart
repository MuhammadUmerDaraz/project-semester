import 'package:flutter/material.dart';
import 'package:umer_wallpaper/Screens/wallpaper.dart';
import 'package:umer_wallpaper/color.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Umer Wallpaper',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: buttonColor,
        useMaterial3: true,
      ),
      home: const WallpaperScreen(),
    );
  }
}

