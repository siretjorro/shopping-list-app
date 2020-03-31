import 'package:flutter/material.dart';
import 'package:shopping_list_app/bloc/list_item_bloc.dart';
import 'package:shopping_list_app/model/list_item.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:shopping_list_app/res/strings.dart' as Strings;

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
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.25,
      child: Container(
        child: CheckboxListTile(
          activeColor: Colors.amberAccent,
          checkColor: Colors.red,
          key: ValueKey(widget.listItem),
          title: Text(widget.listItem.description),
          value: widget.listItem.completed,
          onChanged: (bool value) {
            _handleCheckboxCheck(value);
          }),
      ),
      secondaryActions: <Widget>[
        IconSlideAction(
          caption: Strings.DELETE,
          color: Colors.red,
          icon: Icons.delete,
          onTap: () => _handleDismiss(),
        ),
      ],
    );
  }

  void _handleDismiss() {
    _listItemBloc.deleteListItemById(widget.listItem.id);
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
