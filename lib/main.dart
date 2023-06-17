import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:quiz_v2/UI/Home/welcome_screen.dart';
import 'package:quiz_v2/providers/player_provider.dart';
import 'package:quiz_v2/providers/question_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // locks the screen orientation to portrait mode
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => QuesProvider()),
        ChangeNotifierProvider(create: (_) => PlayerProvider()),
      ],
      child: MaterialApp(
        title: 'Quiz App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          useMaterial3: true,
          // fontFamily: 'Alfa',
        ),
        home: const WelcomeScreen(),
      ),
    );
  }
}
