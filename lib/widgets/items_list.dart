import 'package:flutter/material.dart';
import 'package:shopping_list_app/model/list_item.dart';
import 'package:shopping_list_app/provider/api_provider.dart';
import 'package:shopping_list_app/widgets/list_item_widget.dart';

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
                    ListItemWidget(listItem: item),
                ],
              ),
              onRefresh: _handleRefresh,
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

  Future<void> _handleRefresh() async {
    setState(() {
      this._listItems = _apiProvider.getListItems();
    });
  }
}
