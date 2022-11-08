import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:number_trivia_clean_arch/core/error/exeptions.dart';
import 'package:number_trivia_clean_arch/features/number_trivia/data/datasources/number_trivia_remote_data_source.dart';
import 'package:number_trivia_clean_arch/features/number_trivia/data/models/number_trivia_model.dart';

import '../../../../fixtures/fixture_reader.dart';
import 'number_trivia_remote_data_source_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  late NumberTriviaRemoteDataSourceImpl dataSource;
  late MockClient mockClient;

  setUp(() {
    mockClient = MockClient();
    dataSource = NumberTriviaRemoteDataSourceImpl(client: mockClient);
  });

  group('getting concrete number trivia', () {
    final testNumber = 1;
    test('should get number info in json', () {
      when(mockClient.get(any, headers: anyNamed('headers')))
          .thenAnswer((_) async => http.Response(fixture('trivia.json'), 200));

      dataSource.getConcreteNumberTrivia(testNumber);

      verify(mockClient.get(
          Uri(
            scheme: 'http',
            host: 'numbersapi.com',
            path: '/$testNumber',
          ),
          headers: {
            'Content-Type': 'application/json',
          }));
    });
  });
}
