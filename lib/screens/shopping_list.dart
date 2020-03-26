import 'package:flutter/material.dart';

class ShoppingList extends StatefulWidget {
  @override
  ShoppingListState createState() => ShoppingListState();
}

class ShoppingListState extends State<ShoppingList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            FutureBuilder<List<Todo>>(
              future: todos,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Expanded(
                    child: RefreshIndicator(
                      child: ReorderableListView(
                        padding: EdgeInsets.only(top: 20),
                        children: <Widget>[
                          for (final item in snapshot.data)
                            CheckboxListTile(
                              key: ValueKey(item),
                              title: Text(item.toDoTaskName),
                              value: _getDoneStatus(item),
                              onChanged: (bool value) {
                                Todo updatedTodo = item;
                                updatedTodo.isCompleted = true;
                                updateTodo(context, updatedTodo);
                                // change status to done
                              },
                            ),
                        ],
                        onReorder: (int start, int current) {
                          _onReorder(start, current, snapshot.data);
                        },
                      ),
                      onRefresh: () {},
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Text(snapshot.error);
                }
                return Column(
                  children: <Widget>[
                    Center(
                      child: CircularProgressIndicator(),
                    ),
                  ],
                );
              },
            )
          ]),
    );
  }
}
