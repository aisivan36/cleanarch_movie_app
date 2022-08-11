import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'injection.dart' as di;

void main() {
  //  TODO declare an Injection here
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        /// General things
      ],
    );
  }
}
