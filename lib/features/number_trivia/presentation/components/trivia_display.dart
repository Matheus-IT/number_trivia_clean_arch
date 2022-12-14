import 'package:flutter/material.dart';
import 'package:number_trivia_clean_arch/features/number_trivia/domain/entities/number_trivia.dart';

class TriviaDisplay extends StatelessWidget {
  final NumberTrivia numberTrivia;

  const TriviaDisplay({
    required this.numberTrivia,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 2.5,
      child: Column(
        children: [
          Text(
            numberTrivia.number.toString(),
            style: const TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: Text(
              numberTrivia.text,
              style: const TextStyle(fontSize: 25),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
