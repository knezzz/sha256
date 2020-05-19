import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sha256/ui/animated_view.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        cursorColor: Colors.green,
        scaffoldBackgroundColor: Colors.black,
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme:
            GoogleFonts.firaCodeTextTheme(ThemeData.dark().textTheme.apply(fontSizeFactor: 1.0, fontSizeDelta: 0.0)),
      ),
      home: AnimatedScreen(),
    );
  }
}
