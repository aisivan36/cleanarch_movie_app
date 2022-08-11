import 'package:cleanarch_movie_app/core/styles/colors.dart';
import 'package:cleanarch_movie_app/core/styles/text_styles.dart';
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
        // ChangeNotifierProvider(create:
        // (context) => ,
        // )
      ],
      child: MaterialApp(
        title: 'Movie Database App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark().copyWith(
          primaryColor: kRichBlack,
          scaffoldBackgroundColor: kRichBlack,
          textTheme: kTextTheme,
          colorScheme: kColorScheme.copyWith(
            secondary: Colors.redAccent,
          ),
        ),
      ),
    );
  }
}
