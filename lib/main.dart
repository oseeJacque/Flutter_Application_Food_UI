import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'src/widgets/HomePage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(       
        primarySwatch: Colors.blue,
        textTheme: GoogleFonts.reemKufiTextTheme(
          Theme.of(context).textTheme),
        ),
      home: HomePage(),
    );
  }
}

