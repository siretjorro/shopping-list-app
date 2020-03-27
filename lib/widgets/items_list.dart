import 'package:flutter/material.dart';
import 'package:shopping_list_app/model/list_item.dart';
import 'package:shopping_list_app/provider/api_provider.dart';

class ItemsList extends StatefulWidget {
  @override
  _ItemsListState createState() => _ItemsListState();
}

class _ItemsListState extends State<ItemsList> {
  Future<List<ListItem>> _listItems;
  ApiProvider _apiProvider = ApiProvider();

  @override
  void initState() {
    super.initState();
    this._listItems = _apiProvider.getListItems();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ListItem>>(
      future: _listItems,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Expanded(
            child: RefreshIndicator(
              child: ListView(
                padding: EdgeInsets.only(top: 20),
                children: <Widget>[
                  for (final item in snapshot.data)
                    CheckboxListTile(
                      key: ValueKey(item),
                      title: Text(item.description),
                      value: item.completed,
                      onChanged: (bool value) {
                        ListItem updatedTodo = item;
                        updatedTodo.completed = true;
                        // _updateTodo(context, updatedTodo);
                        // change status to done
                      },
                    ),
                ],
              ),
              onRefresh: () {},
            ),
          );
        } else if (snapshot.hasError) {
          return Text(snapshot.error.toString());
        }
        return Column(
          children: <Widget>[
            Center(
              child: CircularProgressIndicator(),
            ),
          ],
        );
      },
    );
  }
}
