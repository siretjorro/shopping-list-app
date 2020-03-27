import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shopping_list_app/model/list_item.dart';
import 'dart:io';
import 'dart:convert';
import 'dart:async';
import 'package:shopping_list_app/provider/failure.dart';
import 'package:shopping_list_app/res/strings.dart' as Strings;

class ApiProvider {
  Future<List<ListItem>> getListItems() async {
    try {
      final response = _response(await http.get(Strings.BASE_URL + "?apikey=" + Strings.API_KEY));
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
