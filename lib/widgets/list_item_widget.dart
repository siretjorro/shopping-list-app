import 'package:flutter/material.dart';
import 'package:shopping_list_app/model/list_item.dart';
import 'package:shopping_list_app/provider/api_provider.dart';

class ListItemWidget extends StatefulWidget {
  final ListItem listItem;
  const ListItemWidget({Key key, this.listItem}) : super(key: key);
  @override
  _ListItemWidgetState createState() => _ListItemWidgetState();
}

class _ListItemWidgetState extends State<ListItemWidget> {
  final ApiProvider _apiProvider = ApiProvider();

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      key: ValueKey(widget.listItem),
      title: Text(widget.listItem.description),
      value: widget.listItem.completed,
      onChanged: (bool value) {
        _handleCheckboxCheck(value);}
    );
  }

  void _handleCheckboxCheck(bool value) {
    ListItem completedItem = widget.listItem;
    completedItem.completed = !completedItem.completed;
    _completeListItem(completedItem);
    setState(() {});
  }

  void _completeListItem(ListItem listItem) {
    _apiProvider.updateListItem(listItem);
  }
}
