import 'package:flutter/material.dart';
import 'HomeScreen.dart';

import 'package:flutter/foundation.dart' show debugDefaultTargetPlatformOverride;


void main() {
 debugDefaultTargetPlatformOverride = TargetPlatform.fuchsia;
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
 
   @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.white,
        primarySwatch: Colors.grey
      ),
      home:HomeScreen()
    );
  }
}

