import 'dart:convert';

import 'package:number_trivia_clean_arch/core/error/exeptions.dart';
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
  Future<NumberTriviaModel> getConcreteNumberTrivia(int number) async {
    return _getNumberTriviaFromUri(Uri(
      scheme: 'http',
      host: 'numbersapi.com',
      path: '/$number',
    ));
  }

  @override
  Future<NumberTriviaModel> getRandomNumberTrivia() async {
    return _getNumberTriviaFromUri(Uri(
      scheme: 'http',
      host: 'numbersapi.com',
      path: '/random',
    ));
  }

  Future<NumberTriviaModel> _getNumberTriviaFromUri(Uri uri) async {
    final response = await client.get(uri, headers: {
      'Content-Type': 'application/json',
    });
    if (response.statusCode == 200) {
      return NumberTriviaModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }
}
