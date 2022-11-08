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
  NumberTriviaRemoteDataSourceImpl dataSource;
  MockClient mockClient;

  setUp(() {
    mockClient = MockClient();
    dataSource = NumberTriviaRemoteDataSourceImpl(client: mockClient);
  });
}
