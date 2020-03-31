import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'package:shopping_list_app/model/list_item.dart';
import 'package:shopping_list_app/provider/api_provider.dart';
import 'package:shopping_list_app/res/strings.dart' as Strings;

class MockClient extends Mock implements http.Client {}

main() {
  ApiProvider apiProvider = ApiProvider();
  final client = MockClient();
  apiProvider.client = client;

  group('getListItems', () {
    test('returns a list of ListItems if the http call completes successfully',
        () async {
      when(client.get(Strings.BASE_URL + "?apikey=" + Strings.API_KEY))
          .thenAnswer((_) async => Response('[]', 200));

      expect(await apiProvider.getListItems(false),
          isInstanceOf<List<ListItem>>());
    });

    test('throws an exception if the http call completes with an error', () {
      when(client.get(Strings.BASE_URL + "?apikey=" + Strings.API_KEY))
          .thenAnswer((_) async => Response('Not Found', 404));

      expect(apiProvider.getListItems(false), throwsException);
    });
  });
}
