import 'package:flutter/material.dart';
import 'package:shopping_list_app/screens/shopping_list.dart';
import 'screens/archive.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Shopping list",
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              indicatorColor: Color(0xff1f7a1f),
              tabs: [
                Tab(icon: Icon(Icons.list)),
                Tab(icon: Icon(Icons.history)),
              ],
            ),
            title: Text("Shopping list"),
            backgroundColor: Color(0xffadebad),
          ),
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
