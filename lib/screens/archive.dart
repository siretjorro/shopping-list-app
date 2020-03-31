import 'package:flutter/material.dart';
import 'package:shopping_list_app/model/list_item.dart';
import 'package:shopping_list_app/provider/api_provider.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:shopping_list_app/res/strings.dart' as Strings;
import 'package:flutter_slidable/flutter_slidable.dart';

class Archive extends StatefulWidget {
  @override
  _ArchiveState createState() => _ArchiveState();
}

class _ArchiveState extends State<Archive> {
  Future<List<ListItem>> _listItems;
  ApiProvider _apiProvider = ApiProvider();

  @override
  void initState() {
    super.initState();
    this._listItems = _getListItems();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            _buildItemsListWidget(),
            _buildInfoBar()
          ]),
    ));
  }

  _buildInfoBar() {
    return Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
      PlatformText(Strings.INFO),
    ]));
  }

  _buildItemsListWidget() {
    return FutureBuilder<List<ListItem>>(
      future: _listItems,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Expanded(
            child: RefreshIndicator(
              child: ListView(
                padding: EdgeInsets.only(top: 20),
                children: <Widget>[
                  for (final item in snapshot.data) _buildListItemWidget(item),
                ],
              ),
              onRefresh: _handleRefresh,
            ),
          );
        } else if (snapshot.hasError) {
          return Container(
              padding: EdgeInsets.only(top: 20),
              child: Column(children: <Widget>[
                Center(
                  child: Text(Strings.DATA_ERROR),
                )
              ]));
        }
        return Container(
            padding: EdgeInsets.only(top: 20),
            child: Column(
              children: <Widget>[
                Center(
                  child: PlatformCircularProgressIndicator(),
                ),
              ],
            ));
      },
    );
  }

  _buildListItemWidget(ListItem listItem) {
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.25,
      child: Container(
        child: CheckboxListTile(
            activeColor: Colors.grey[300],
            checkColor: Colors.blue,
            key: ValueKey(listItem),
            title: Text(listItem.description),
            value: listItem.completed,
            onChanged: (bool value) {
              _handleCheckboxCheck(listItem);
            }),
      ),
      secondaryActions: <Widget>[
        IconSlideAction(
          caption: Strings.DELETE,
          color: Colors.red,
          icon: Icons.delete,
          onTap: () => _handleDismiss(listItem),
        ),
      ],
    );
  }

  _handleDismiss(ListItem listItem) {
    _deleteListItemById(listItem.id);
    _handleRefresh();
  }

  _handleCheckboxCheck(ListItem listItem) {
    ListItem completedItem = listItem;
    completedItem.completed = !completedItem.completed;
    _completeListItem(completedItem);
    setState(() {});
  }

  _completeListItem(ListItem listItem) async {
    await _apiProvider.updateListItem(listItem);
  }

  _deleteListItemById(int id) async {
    await _apiProvider.deleteListItemById(id);
  }

  Future<void> _handleRefresh() async {
    this._listItems = _getListItems();
    setState(() {});
  }

  Future<List<ListItem>> _getListItems() async {
    return await _apiProvider.getListItems(true);
  }
}