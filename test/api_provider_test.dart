// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mockito/mockito.dart';
// import 'package:http/http.dart' as http;
// import 'package:shopping_list_app/model/list_item.dart';

// class MockClient extends Mock implements http.Client {}

// main() {
//   group('getListItems', () {
//     test('returns a list of ListItems if the http call completes successfully', () async {
//       final client = MockClient();

//       when(client.get('https://jsonplaceholder.typicode.com/posts/1'))
//           .thenAnswer((_) async => http.Response('{"title": "Test"}', 200));

//       expect(await getListItems(), const isInstanceOf<List<ListItem>>());
//     });

//     test('throws an exception if the http call completes with an error', () {
//       final client = MockClient();

//       // Use Mockito to return an unsuccessful response when it calls the
//       // provided http.Client.
//       when(client.get('https://jsonplaceholder.typicode.com/posts/1'))
//           .thenAnswer((_) async => http.Response('Not Found', 404));

//       expect(fetchPost(client), throwsException);
//     });
//   });
// }