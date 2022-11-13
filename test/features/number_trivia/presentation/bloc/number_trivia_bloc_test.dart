import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:number_trivia_clean_arch/core/converters/number_input_converter.dart';
import 'package:number_trivia_clean_arch/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:number_trivia_clean_arch/features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';
import 'package:number_trivia_clean_arch/features/number_trivia/domain/usecases/get_random_number_trivia.dart';
import 'package:number_trivia_clean_arch/features/number_trivia/presentation/bloc/number_trivia_bloc.dart';

import 'number_trivia_bloc_test.mocks.dart';

@GenerateMocks([
  GetConcreteNumberTrivia,
  GetRandomNumberTrivia,
  NumberInputConverter,
])
void main() {
  late MockGetConcreteNumberTrivia getConcreteNumberTrivia;
  late MockGetRandomNumberTrivia getRandomNumberTrivia;
  late MockNumberInputConverter inputConverter;
  late NumberTriviaBloc bloc;

  setUp(() {
    getConcreteNumberTrivia = MockGetConcreteNumberTrivia();
    getRandomNumberTrivia = MockGetRandomNumberTrivia();
    inputConverter = MockNumberInputConverter();

    bloc = NumberTriviaBloc(
      getConcreteNumberTrivia: getConcreteNumberTrivia,
      getRandomNumberTrivia: getRandomNumberTrivia,
      inputConverter: inputConverter,
    );
  });

  test('initial state should be empty', () {
    expect(bloc.state, equals(Empty()));
  });

  group('get trivia for concrete number', () {
    final testNumberString = '1';
    final testNumberParsed = 1;
    final testNumberTrivia = NumberTrivia(text: 'testing', number: 1);

    test('should validate and convert the string to an unsigned integer',
        () async {
      when(inputConverter.stringToUnsignedInteger('1'))
          .thenReturn(Right(testNumberParsed));

      // bloc.dispatch(GetTriviaForConcreteNumber(testNumberString));

      verify(inputConverter.stringToUnsignedInteger(testNumberString));
    });
  });
}
