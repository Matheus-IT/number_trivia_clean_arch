import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:number_trivia_clean_arch/core/usecases/usecase.dart';
import 'package:number_trivia_clean_arch/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:number_trivia_clean_arch/features/number_trivia/domain/repositories/number_trivia_repository.dart';
import 'package:number_trivia_clean_arch/features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';

import 'number_trivia_repository_test.mocks.dart';

@GenerateMocks([NumberTriviaRepository])
void main() {
  test('should get trivia for the number from the repository', () async {
    final mockNumberTriviaRepository = MockNumberTriviaRepository();
    final usecase = GetConcreteNumberTrivia(mockNumberTriviaRepository);
    int testNumber = 1;
    final testNumberTrivia = NumberTrivia(text: 'testing', number: testNumber);
    when(mockNumberTriviaRepository.getConcreteNumberTrivia(1))
        .thenAnswer((_) async => Right(testNumberTrivia));

    final result = await usecase(Params(number: testNumber));

    expect(result, Right(testNumberTrivia));
    verify(mockNumberTriviaRepository.getConcreteNumberTrivia(testNumber));
    verifyNoMoreInteractions(mockNumberTriviaRepository);
  });
}
