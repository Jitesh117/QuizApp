import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_v2/UI/Home/home.dart';
import 'package:quiz_v2/providers/question_provider.dart';

void main() {
  runApp(const MyApp());
}
// TODO: 1.random topic questions(chaos mode)
// TODO: 2.customised settings(no of questions,, type(true/false, mcq), time limit)
// TODO: 3. Rewards( badges, coins, in app purchases)
// TODO: 4. notifications( daily challenge: special rewards)
// TODO: 5. social sharing

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => QuesProvider()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          useMaterial3: true,
        ),
        home: const HomePage(),
      ),
    );
  }
}
