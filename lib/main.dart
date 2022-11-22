import 'package:flutter/material.dart';
import 'package:number_trivia_clean_arch/features/number_trivia/presentation/pages/number_trivia_page.dart';
import 'package:number_trivia_clean_arch/injection_container.dart' as injection_container;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await injection_container.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Number Trivia',
      theme: ThemeData(
        primarySwatch: Colors.yellow,
      ),
      home: const NumberTriviaPage(),
    );
  }
}
