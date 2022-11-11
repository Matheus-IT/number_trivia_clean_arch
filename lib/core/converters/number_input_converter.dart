import 'package:dartz/dartz.dart';
import 'package:number_trivia_clean_arch/core/error/failures.dart';

class NumberInputConverter {
  Either<Failure, int> stringToUnsignedInteger(String number) {
    try {
      final integer = int.parse(number);

      if (integer < 0) {
        throw const FormatException();
      }
      return Right(integer);
    } on FormatException {
      return Left(InvalidInputFailure());
    }
  }
}

class InvalidInputFailure extends Failure {
  @override
  List<Object?> get props => [];
}
