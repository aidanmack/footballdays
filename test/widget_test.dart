import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:footballdays/domain_models.dart';
import 'package:footballdays/footballService/football_service.dart';
import 'fake_api_service.dart';

void main() {
  test('Test', () async {
    final container = ProviderContainer(
      overrides: [apiService.overrideWithValue(FAKEApiService())],
    );

    expect(
      container.read(getTopPremTeam),
      const AsyncValue<TeamInfo>.loading(),
    );

    await container.read(getTopPremTeam.future);

    expect(container.read(getTopPremTeam).value?.founded, '1909');
  });
}
