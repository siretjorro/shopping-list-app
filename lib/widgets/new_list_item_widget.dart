import 'package:flutter/material.dart';
import 'package:shopping_list_app/bloc/list_item_bloc.dart';
import 'package:shopping_list_app/model/list_item.dart';

class NewListItemWidget extends StatefulWidget {
  @override
  _NewListItemWidgetState createState() => _NewListItemWidgetState();
}

class _NewListItemWidgetState extends State<NewListItemWidget> {
  String _newListItem;
  final textControllerNewListItem = TextEditingController();
  final ListItemBloc _listItemBloc = ListItemBloc();

  _NewListItemWidgetState() {
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
    return Column(children: <Widget>[
      Container(
        child: TextField(
          controller: textControllerNewListItem,
          decoration: InputDecoration(labelText: 'New todo'),
        ),
      ),
      SizedBox(
        width: double.infinity,
        child: RaisedButton(
          child: Text('Add'),
          onPressed: () {
            _addNewListItem();
          },
        ),
      )
    ]);
  }

  _addNewListItem() {
    _listItemBloc.addListItem(new ListItem(description: _newListItem));
    textControllerNewListItem.text = "";
  }
}
