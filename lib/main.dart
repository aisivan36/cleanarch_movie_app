import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'injection.dart' as di;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [],
    );
  }
}
