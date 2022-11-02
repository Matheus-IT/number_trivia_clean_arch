import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:data_connection_checker_nulls/data_connection_checker_nulls.dart';
import 'package:number_trivia_clean_arch/core/network/network_info.dart';

import 'network_info_test.mocks.dart';

@GenerateMocks([DataConnectionChecker])
void main() {
  late NetworkInfoImpl networkInfoImpl;
  late MockDataConnectionChecker mockDataConnectionChecker;

  setUp(() {
    mockDataConnectionChecker = MockDataConnectionChecker();
    networkInfoImpl = NetworkInfoImpl(mockDataConnectionChecker);
  });

  group('is connected', () {
    test('should return if has connection', () async {
      when(mockDataConnectionChecker.hasConnection)
          .thenAnswer((_) async => true);

      final result = await networkInfoImpl.isConnected;

      verify(mockDataConnectionChecker.hasConnection);
      expect(result, true);
    });

    test('should return if does not have connection', () async {
      when(mockDataConnectionChecker.hasConnection)
          .thenAnswer((_) async => false);

      final result = await networkInfoImpl.isConnected;

      verify(mockDataConnectionChecker.hasConnection);
      expect(result, false);
    });
  });
}
