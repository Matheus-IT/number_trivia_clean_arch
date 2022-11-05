import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:number_trivia_clean_arch/core/error/exeptions.dart';
import 'package:number_trivia_clean_arch/features/number_trivia/data/datasources/number_trivia_local_data_source.dart';
import 'package:number_trivia_clean_arch/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../fixtures/fixture_reader.dart';
import 'number_trivia_local_data_source_test.mocks.dart';

@GenerateMocks([SharedPreferences])
void main() {
  late NumberTriviaLocalDataSourceImpl datasource;
  late MockSharedPreferences mockSharedPreferences;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    datasource = NumberTriviaLocalDataSourceImpl(
      sharedPreferences: mockSharedPreferences,
    );
  });

  group('getLastNumberTrivia', () {
    final testNumberTriviaModel =
        NumberTriviaModel.fromJson(json.decode(fixture('trivia.json')));

    test(
        'should return number trivia from shared preferences when there is one in the cache',
        () async {
      when(mockSharedPreferences.getString(cachedNumberTrivia))
          .thenReturn(fixture('trivia.json'));

      final result = await datasource.getLastNumberTrivia();

      verify(mockSharedPreferences.getString(cachedNumberTrivia));
      expect(result, equals(testNumberTriviaModel));
    });

    test('should throw a cache exception when there is no cached value',
        () async {
      when(mockSharedPreferences.getString(cachedNumberTrivia))
          .thenReturn(null);

      final method = datasource.getLastNumberTrivia;

      expect(() => method(), throwsA(const TypeMatcher<CacheException>()));
    });
  });

  group('getLastNumberTrivia', () {
    const testNumberTriviaModel =
        NumberTriviaModel(number: 1, text: 'testing 123');

    test('should call shared preferences to cache the data', () async {
      when(mockSharedPreferences.getString(cachedNumberTrivia))
          .thenReturn(null);

      datasource.cacheNumberTrivia(testNumberTriviaModel);

      final expectedJsonString = json.encode(testNumberTriviaModel.toJson());
      verify(mockSharedPreferences.setString(
        cachedNumberTrivia,
        expectedJsonString,
      ));
    });
  });
}
