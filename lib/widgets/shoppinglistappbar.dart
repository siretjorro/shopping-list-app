import 'package:flutter/material.dart';

class ShoppingListAppBar extends StatelessWidget with PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      bottom: TabBar(
        tabs: [
          Tab(icon: Icon(Icons.list)),
          Tab(icon: Icon(Icons.history)),
        ],
      ),
      title: Text("Shopping list"),
      backgroundColor: Colors.pink,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(100);
}
