import 'package:flutter/material.dart';
import 'package:shopping_list_app/widgets/items_list_widget.dart';
import 'package:shopping_list_app/widgets/new_list_item_widget.dart';

class ShoppingList extends StatefulWidget {
  @override
  ShoppingListState createState() => ShoppingListState();
}

class ShoppingListState extends State<ShoppingList> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            ItemsListWidget(),
          ]),
    );
  }
}
