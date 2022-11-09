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

  void setUpMockHttpClientOkResponse() {
    when(mockClient.get(any, headers: anyNamed('headers')))
        .thenAnswer((_) async => http.Response(fixture('trivia.json'), 200));
  }

  void setUpMockHttpClientNotFoundResponse() {
    when(mockClient.get(any, headers: anyNamed('headers')))
        .thenAnswer((_) async => http.Response('something went wrong', 404));
  }

  group('getting concrete number trivia', () {
    const testNumber = 1;
    final testNumberTriviaModel =
        NumberTriviaModel.fromJson(json.decode(fixture('trivia.json')));

    test('should get number info in json', () {
      setUpMockHttpClientOkResponse();

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

    test('should return number trivia when the response code is successful',
        () async {
      setUpMockHttpClientOkResponse();

      final result = await dataSource.getConcreteNumberTrivia(testNumber);

      expect(result, equals(testNumberTriviaModel));
    });

    test('should throw a server exception when the response is other than ok',
        () async {
      setUpMockHttpClientNotFoundResponse();

      final call = dataSource.getConcreteNumberTrivia;

      expect(
        () => call(testNumber),
        throwsA(const TypeMatcher<ServerException>()),
      );
    });
  });
}
