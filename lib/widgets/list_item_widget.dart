import 'package:flutter/material.dart';
import 'package:shopping_list_app/bloc/list_item_bloc.dart';
import 'package:shopping_list_app/model/list_item.dart';

class ListItemWidget extends StatefulWidget {
  final ListItem listItem;
  const ListItemWidget({Key key, this.listItem}) : super(key: key);
  @override
  _ListItemWidgetState createState() => _ListItemWidgetState();
}

class _ListItemWidgetState extends State<ListItemWidget> {
  final ListItemBloc _listItemBloc = ListItemBloc();

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(widget.listItem),
      onDismissed: (direction) {
        _handleDismiss();
      },
      background: Container(color: Colors.red),
      child: CheckboxListTile(
          key: ValueKey(widget.listItem),
          title: Text(widget.listItem.description),
          value: widget.listItem.completed,
          onChanged: (bool value) {
            _handleCheckboxCheck(value);
          }),
    );
  }

  void _handleDismiss() {
    _listItemBloc.deleteListItemById(widget.listItem.id);
    Scaffold.of(context).showSnackBar(
        SnackBar(content: Text("${widget.listItem.description} deleted")));
  }

  void _handleCheckboxCheck(bool value) {
    ListItem completedItem = widget.listItem;
    completedItem.completed = !completedItem.completed;
    _completeListItem(completedItem);
  }

  void _completeListItem(ListItem listItem) {
    _listItemBloc.updateListItem(listItem);
  }
}
