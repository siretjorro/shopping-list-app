import 'package:flutter/material.dart';
import 'package:shopping_list_app/model/list_item.dart';
import 'package:shopping_list_app/provider/api_provider.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:shopping_list_app/res/strings.dart' as Strings;

class ShoppingList extends StatefulWidget {
  @override
  _ShoppingListState createState() => _ShoppingListState();
}

class _ShoppingListState extends State<ShoppingList> {
  Future<List<ListItem>> _listItems;
  ApiProvider _apiProvider = ApiProvider();
  String _newListItem;
  final textControllerNewListItem = TextEditingController();

  @override
  void initState() {
    super.initState();
    this._listItems = _getListItems();
  }

  _ShoppingListState() {
    textControllerNewListItem.addListener(_newListItemListener);
  }

  void _newListItemListener() {
    if (textControllerNewListItem.text.isEmpty) {
      _newListItem = "";
    } else {
      _newListItem = textControllerNewListItem.text;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            _buildNewListItemWidget(),
            _buildItemsListWidget(),
          ]),
    ));
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

  Future<void> _handleRefresh() async {
    this._listItems = _getListItems();
    setState(() {});
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

  Future<List<ListItem>> _getListItems() async {
    return await _apiProvider.getListItems(false);
  }

  _buildNewListItemWidget() {
    return Container(
        padding: EdgeInsets.all(16),
        color: Color(0xffe6f2ff),
        child: Column(children: <Widget>[
          Container(
            child: PlatformTextField(
              controller: textControllerNewListItem,
              android: (_) => MaterialTextFieldData(
                decoration: InputDecoration(labelText: Strings.NEW_ITEM),
              ),
              ios: (_) => CupertinoTextFieldData(
                placeholder: Strings.NEW_ITEM,
              ),
            ),
          ),
          PlatformButton(
            child: PlatformText(Strings.ADD),
            onPressed: () {
              _addNewListItem();
            },
          ),
        ]));
  }

  _addNewListItem() async {
    await _apiProvider.createListItem(new ListItem(description: _newListItem));
    textControllerNewListItem.text = "";
    _handleRefresh();
  }
}
