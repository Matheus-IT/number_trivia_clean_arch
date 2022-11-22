import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:number_trivia_clean_arch/features/number_trivia/presentation/bloc/number_trivia_bloc.dart';
import 'package:number_trivia_clean_arch/injection_container.dart';

class NumberTriviaPage extends StatelessWidget {
  const NumberTriviaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Number trivia'),
      ),
      body: BlocProvider(
        create: (_) => sl<NumberTriviaBloc>(),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(
                height: 16,
              ),
              Container(
                height: MediaQuery.of(context).size.height / 2.5,
                child: Placeholder(),
              ),
              SizedBox(
                height: 32,
              ),
              Column(
                children: [
                  Placeholder(
                    fallbackHeight: 50,
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                          child: Placeholder(
                        fallbackHeight: 40,
                      )),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                          child: Placeholder(
                        fallbackHeight: 40,
                      ))
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
