import 'package:http/http.dart' as http;
import 'package:shopping_list_app/model/list_item.dart';
import 'dart:io';
import 'dart:convert';
import 'dart:async';
import 'package:shopping_list_app/provider/failure.dart';
import 'package:shopping_list_app/res/strings.dart' as Strings;

class ApiProvider {
  Future<List<ListItem>> getListItems({bool completed}) async {
    try {
      final response = _response(
          await http.get(Strings.BASE_URL + "?apikey=" + Strings.API_KEY));
      var list = json.decode(response.body) as List;

      if (completed != null) {
        return list
            .map((i) => ListItem.fromJson(i))
            .where((f) => f.completed == completed)
            .toList();
      } else {
        return list.map((i) => ListItem.fromJson(i)).toList();
      }
    } on SocketException {
      throw Failure("No Internet connection, couldn't load data 😕");
    }
  }

  Future<void> updateListItem(ListItem listItem) async {
    Map<String, String> headers = {'Content-type': 'application/json'};

    try {
      return _response(await http.put(
          Strings.BASE_URL +
              listItem.id.toString() +
              "/?apikey=" +
              Strings.API_KEY,
          headers: headers,
          body: json.encode({
            'id': listItem.id,
            'description': listItem.description,
            'completed': listItem.completed
          })));
    } on SocketException {
      throw Failure("No Internet connection, couldn't load data 😕");
    }
  }

  Future<ListItem> createListItem(ListItem listItem) async {
    Map<String, String> headers = {'Content-type': 'application/json'};

    try {
      final response = _response(await http.post(
          Strings.BASE_URL + "?apikey=" + Strings.API_KEY,
          headers: headers,
          body: json.encode({'description': listItem.description})));
      print("create list item");
      return ListItem.fromJson(json.decode(response.body));
    } on SocketException {
      throw Failure("No Internet connection, couldn't load data 😕");
    }
  }

  Future<void> deleteListItemById(int id) async {
Map<String, String> headers = {'Content-type': 'application/json'};

    try {
      return _response(await http.delete(
          Strings.BASE_URL + id.toString() +
              "/?apikey=" +
              Strings.API_KEY,
          headers: headers));
    } on SocketException {
      throw Failure("No Internet connection, couldn't load data 😕");
    }
  }

  dynamic _response(http.Response response) {
    switch (response.statusCode) {
      case 200:
        return response;
      case 201:
        return response;
      case 204:
        return response;
      // TODO: add more handling
      default:
        print(response.statusCode);
        throw Failure("Error loading data 😕");
    }
  }
}
