import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:number_trivia_clean_arch/features/number_trivia/presentation/bloc/number_trivia_bloc.dart';
import 'package:number_trivia_clean_arch/features/number_trivia/presentation/components/load_indicator.dart';
import 'package:number_trivia_clean_arch/features/number_trivia/presentation/components/message_display.dart';
import 'package:number_trivia_clean_arch/features/number_trivia/presentation/components/trivia_controls.dart';
import 'package:number_trivia_clean_arch/features/number_trivia/presentation/components/trivia_display.dart';
import 'package:number_trivia_clean_arch/injection_container.dart';

class NumberTriviaPage extends StatelessWidget {
  const NumberTriviaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Number trivia'),
      ),
      body: SingleChildScrollView(
        child: BlocProvider(
          create: (_) => sl<NumberTriviaBloc>(),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                const SizedBox(
                  height: 16,
                ),
                BlocBuilder<NumberTriviaBloc, NumberTriviaState>(
                  builder: (context, state) {
                    if (state is Empty) {
                      return const MessageDisplay(message: 'Start searching!');
                    }
                    if (state is Loading) {
                      return const LoadIndicator();
                    }
                    if (state is Loaded) {
                      return TriviaDisplay(numberTrivia: state.trivia);
                    }
                    if (state is Error) {
                      return MessageDisplay(message: state.message);
                    }
                    return Container();
                  },
                ),
                const SizedBox(
                  height: 32,
                ),
                const TriviaControls()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
