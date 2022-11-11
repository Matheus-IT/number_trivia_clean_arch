import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:number_trivia_clean_arch/core/converters/number_input_converter.dart';
import 'package:number_trivia_clean_arch/core/error/failures.dart';

void main() {
  late NumberInputConverter converter;

  setUp(() {
    converter = NumberInputConverter();
  });

  group('convert string to unsigned number', () {
    test('should return an integer when the given string represents it', () {
      const str = '123';

      final result = converter.stringToUnsignedInteger(str);

      expect(result, const Right(123));
    });

    test('should return a failure when input is not a number', () {
      const str = 'abc';

      final result = converter.stringToUnsignedInteger(str);

      expect(result, Left(InvalidInputFailure()));
    });

    test('should return a failure when input is a negative number', () {
      const str = '-123';

      final result = converter.stringToUnsignedInteger(str);

      expect(result, Left(InvalidInputFailure()));
    });
  });
}
