import 'package:flutter/material.dart';

class ListItem {
  int id;
  String description;
  bool completed;

  ListItem({this.id, @required this.description, this.completed});

  factory ListItem.fromJson(Map<String, dynamic> json) {
    return ListItem(
        id: json['id'],
        description: json['description'],
        completed: json['completed']);
  }
}
