import 'package:flutter/material.dart';
import 'package:shopping_list_app/bloc/list_item_bloc.dart';
import 'package:shopping_list_app/model/list_item.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:shopping_list_app/res/strings.dart' as Strings;

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

  _addNewListItem() {
    _listItemBloc.addListItem(new ListItem(description: _newListItem));
    textControllerNewListItem.text = "";
  }
}
