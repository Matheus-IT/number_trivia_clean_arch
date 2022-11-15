import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:number_trivia_clean_arch/core/converters/number_input_converter.dart';
import 'package:number_trivia_clean_arch/core/error/failures.dart';
import 'package:number_trivia_clean_arch/core/usecases/usecase.dart';
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
    const testNumberString = '1';
    const testInvalidNumberString = '-1';
    const testNumberParsed = 1;
    const testNumberTrivia = NumberTrivia(text: 'testing', number: 1);

    setUpInputConverterWhenSuccess() {
      when(
        inputConverter.stringToUnsignedInteger('1'),
      ).thenReturn(const Right(testNumberParsed));
    }

    setUpInputConverterWhenInvalidInput() {
      when(
        inputConverter.stringToUnsignedInteger('-1'),
      ).thenReturn(Left(InvalidInputFailure()));
    }

    setUpUseCaseForCacheFailure() {
      when(
        getConcreteNumberTrivia(const Params(number: testNumberParsed)),
      ).thenAnswer((_) async => Left(CacheFailure()));
    }

    setUpUseCaseForServerFailure() {
      when(
        getConcreteNumberTrivia(const Params(number: testNumberParsed)),
      ).thenAnswer((_) async => Left(ServerFailure()));
    }

    setUpUseCaseForSuccess() {
      when(
        getConcreteNumberTrivia(const Params(number: testNumberParsed)),
      ).thenAnswer((_) async => const Right(testNumberTrivia));
    }

    blocTest(
      'should emit correct events with proper message when cache failure',
      setUp: () {
        setUpInputConverterWhenSuccess();
        setUpUseCaseForCacheFailure();
      },
      build: () => bloc,
      act: (bloc) => bloc.add(const GetTriviaForConcreteNumber(testNumberString)),
      expect: () => [Loading(), const Error(message: CACHE_FAILURE_MESSAGE)],
    );

    blocTest(
      'should emit correct events when server failure',
      setUp: () {
        setUpInputConverterWhenSuccess();
        setUpUseCaseForServerFailure();
      },
      build: () => bloc,
      act: (bloc) => bloc.add(const GetTriviaForConcreteNumber(testNumberString)),
      expect: () => [Loading(), const Error(message: SERVER_FAILURE_MESSAGE)],
    );

    blocTest(
      'should emit an error when the input is invalid',
      setUp: () => setUpInputConverterWhenInvalidInput(),
      build: () => bloc,
      act: (bloc) => bloc.add(const GetTriviaForConcreteNumber(testInvalidNumberString)),
      expect: () => [const Error(message: INVALID_INPUT_FAILURE_MESSAGE)],
    );

    blocTest(
      'should emit loaded when successful',
      setUp: () {
        setUpInputConverterWhenSuccess();
        setUpUseCaseForSuccess();
      },
      build: () => bloc,
      act: (bloc) => bloc.add(const GetTriviaForConcreteNumber(testNumberString)),
      expect: () => [Loading(), const Loaded(trivia: testNumberTrivia)],
    );
  });

  group('get trivia for random number', () {
    const testNumberParsed = 1;
    const testNumberTrivia = NumberTrivia(text: 'testing', number: 1);

    setUpRandomUseCaseWhenSuccess() {
      when(
        getRandomNumberTrivia(NoParams()),
      ).thenAnswer((_) async => const Right(testNumberTrivia));
    }

    setUpUseCaseForCacheFailure() {
      when(
        getRandomNumberTrivia(NoParams()),
      ).thenAnswer((_) async => Left(CacheFailure()));
    }

    setUpUseCaseForServerFailure() {
      when(
        getRandomNumberTrivia(NoParams()),
      ).thenAnswer((_) async => Left(ServerFailure()));
    }

    blocTest(
      'should emit correct events when cache failure',
      setUp: () {
        setUpUseCaseForCacheFailure();
      },
      build: () => bloc,
      act: (bloc) => bloc.add(GetTriviaForRandomNumber()),
      expect: () => [Loading(), const Error(message: CACHE_FAILURE_MESSAGE)],
    );

    blocTest(
      'should emit correct events when server failure',
      setUp: () {
        setUpUseCaseForServerFailure();
      },
      build: () => bloc,
      act: (bloc) => bloc.add(GetTriviaForRandomNumber()),
      expect: () => [Loading(), const Error(message: SERVER_FAILURE_MESSAGE)],
    );

    blocTest(
      'should emit loaded when successful',
      setUp: () => setUpRandomUseCaseWhenSuccess(),
      build: () => bloc,
      act: (bloc) => bloc.add(GetTriviaForRandomNumber()),
      expect: () => [Loading(), const Loaded(trivia: testNumberTrivia)],
    );
  });
}
