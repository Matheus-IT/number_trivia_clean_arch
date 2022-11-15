import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:number_trivia_clean_arch/core/converters/number_input_converter.dart';
import 'package:number_trivia_clean_arch/core/error/failures.dart';
import 'package:number_trivia_clean_arch/core/usecases/usecase.dart';
import 'package:number_trivia_clean_arch/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:number_trivia_clean_arch/features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';
import 'package:number_trivia_clean_arch/features/number_trivia/domain/usecases/get_random_number_trivia.dart';

part 'number_trivia_event.dart';
part 'number_trivia_state.dart';

const SERVER_FAILURE_MESSAGE = 'Server Failure';
const CACHE_FAILURE_MESSAGE = 'Cache Failure';
const INVALID_INPUT_FAILURE_MESSAGE = 'Input Failure';

class NumberTriviaBloc extends Bloc<NumberTriviaEvent, NumberTriviaState> {
  final GetConcreteNumberTrivia getConcreteNumberTrivia;
  final GetRandomNumberTrivia getRandomNumberTrivia;
  final NumberInputConverter inputConverter;

  NumberTriviaBloc({
    required this.getConcreteNumberTrivia,
    required this.getRandomNumberTrivia,
    required this.inputConverter,
  }) : super(Empty()) {
    on<GetTriviaForConcreteNumber>((event, emit) {
      final inputEither = inputConverter.stringToUnsignedInteger(event.numberInput);
      inputEither.fold(
        (failure) {
          emit(const Error(message: INVALID_INPUT_FAILURE_MESSAGE));
        },
        (integer) async {
          emit(Loading());

          final failureOrTrivia = await getConcreteNumberTrivia(Params(number: integer));

          failureOrTrivia.fold(
            (failure) => emit(Error(message: _mapFailureToMessage(failure))),
            (trivia) => emit(Loaded(trivia: trivia)),
          );
        },
      );
    });
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case CacheFailure:
        return CACHE_FAILURE_MESSAGE;
      default:
        return 'Unexpected Error';
    }
  }
}
