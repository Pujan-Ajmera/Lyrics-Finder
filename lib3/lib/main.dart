import 'package:flutter/material.dart';
import 'package:lyrics_app/pages/colors.dart';
import 'package:lyrics_app/pages/homepage.dart';
import 'package:lyrics_app/pages/test_delete_karje.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor:  MyColors().color2,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: SearchPage(),
    );
  }
}