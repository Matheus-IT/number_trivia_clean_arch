import 'package:number_trivia_clean_arch/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:http/http.dart' as http;

abstract class NumberTriviaRemoteDataSource {
  Future<NumberTriviaModel> getConcreteNumberTrivia(int number);
  Future<NumberTriviaModel> getRandomNumberTrivia();
}

class NumberTriviaRemoteDataSourceImpl implements NumberTriviaRemoteDataSource {
  final http.Client client;

  NumberTriviaRemoteDataSourceImpl({required this.client});

  @override
  Future<NumberTriviaModel> getConcreteNumberTrivia(int number) {
    // TODO: implement getConcreteNumberTrivia
    throw UnimplementedError();
  }

  @override
  Future<NumberTriviaModel> getRandomNumberTrivia() {
    // TODO: implement getRandomNumberTrivia
    throw UnimplementedError();
  }
}
