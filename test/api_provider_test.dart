import 'dart:convert';

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
  Map<String, String> headers = {'Content-type': 'application/json'};

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

  group('createListItem', () {
    test('returns a ListItem if the http call completes successfully',
        () async {
      ListItem listItem = ListItem(description: 'beans');

      when(client.post(Strings.BASE_URL + "?apikey=" + Strings.API_KEY,
              headers: headers,
              body: json.encode({'description': listItem.description})))
          .thenAnswer((_) async => Response('[]', 200));

      expect(
          await apiProvider.createListItem(listItem), isInstanceOf<ListItem>());
    });

    test('throws an exception if the http call completes with an error', () {
      Map<String, String> headers = {'Content-type': 'application/json'};
      ListItem listItem = ListItem(description: 'beans');

      when(client.post(Strings.BASE_URL + "?apikey=" + Strings.API_KEY,
              headers: headers, body: json.encode({'description': 'beans'})))
          .thenAnswer((_) async => Response('Not Found', 404));

      expect(apiProvider.createListItem(listItem), throwsException);
    });
  });

  group('updateListItem', () {
    test('throws an exception if the http call completes with an error', () {
      ListItem listItem =
          ListItem(id: 1, description: 'beans', completed: false);

      when(client.put(
              Strings.BASE_URL +
                  listItem.id.toString() +
                  "/?apikey=" +
                  Strings.API_KEY,
              headers: headers,
              body: listItem.toJson()))
          .thenAnswer((_) async => Response('Not Found', 404));

      expect(apiProvider.updateListItem(listItem), throwsException);
    });
  });

  group('deleteListItem', () {
    test('throws an exception if the http call completes with an error', () {
      int id = 1;

      when(client.delete(
              Strings.BASE_URL + id.toString() + "/?apikey=" + Strings.API_KEY,
              headers: headers))
          .thenAnswer((_) async => Response('Not Found', 404));

      expect(apiProvider.deleteListItemById(id), throwsException);
    });
  });
}
