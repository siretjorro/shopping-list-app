import 'package:flutter/material.dart';
import 'widgets/shoppinglistappbar.dart';
import 'screens/archive.dart';
import 'screens/shoppinglist.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Shopping list",
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: ShoppingListAppBar(),
          body: TabBarView(
            children: [
              ShoppingList(),
              Archive(),
            ],
          ),
        ),
      ),
    );
  }
}