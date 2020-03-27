import 'package:http/http.dart' as http;
import 'package:shopping_list_app/model/list_item.dart';
import 'dart:io';
import 'dart:convert';
import 'dart:async';
import 'package:shopping_list_app/provider/failure.dart';

class ApiProvider {
  final String _baseUrl = "https://taltech.akaver.com/api/ListItems/";
  final String _apiKey = "6115a74a-4900-4900-be63-d961bd0c6214";

  Future<List<ListItem>> getListItems() async {
    try {
      final response = _response(await http.get(_baseUrl + "?apikey=" + _apiKey));
      var list = json.decode(response.body) as List;
      List<ListItem> listItems = list.map((i) => ListItem.fromJson(i)).toList();
      return listItems;
    } on SocketException {
      throw Failure("No Internet connection, couldn't load data 😕");
    }
  }

  dynamic _response(http.Response response) {
    switch (response.statusCode) {
      case 200:
        return response;
      // TODO: add more handling
      default:
        throw Failure("Error loading data 😕");
    }
  }
}
