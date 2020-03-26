import 'package:flutter/material.dart';

class ShoppingList extends StatefulWidget {
    @override
  ShoppingListState createState() => ShoppingListState();
}

class ShoppingListState extends State<ShoppingList> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Shopping list"),
    );
  }
}