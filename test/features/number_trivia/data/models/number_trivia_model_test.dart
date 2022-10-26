import 'package:flutter_test/flutter_test.dart';
import 'package:number_trivia_clean_arch/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:number_trivia_clean_arch/features/number_trivia/domain/entities/number_trivia.dart';

void main() {
  const testNumberTriviaModel = NumberTriviaModel(number: 1, text: 'test text');

  test('should be a subclass of number trivia entity', () async {
    expect(testNumberTriviaModel, isA<NumberTrivia>());
  });
}
