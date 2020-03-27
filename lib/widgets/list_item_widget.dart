import 'package:flutter/material.dart';
import 'package:shopping_list_app/model/list_item.dart';

class ListItemWidget extends StatelessWidget {
  final ListItem listItem;

  ListItemWidget({@required this.listItem});

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      key: ValueKey(listItem),
      title: Text(listItem.description),
      value: listItem.completed,
      onChanged: (bool value) {
        ListItem updatedTodo = listItem;
        updatedTodo.completed = true;
        // _updateTodo(context, updatedTodo);
        // change status to done
      },
    );
  }
}
