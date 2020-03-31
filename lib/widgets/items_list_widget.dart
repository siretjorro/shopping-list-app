import 'package:flutter/material.dart';
import 'package:shopping_list_app/bloc/list_item_bloc.dart';
import 'package:shopping_list_app/model/list_item.dart';
import 'package:shopping_list_app/widgets/list_item_widget.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:shopping_list_app/res/strings.dart' as Strings;

class ItemsListWidget extends StatefulWidget {
  final bool completed;
  const ItemsListWidget({Key key, this.completed}) : super(key: key);
  @override
  _ItemsListWidgetState createState() => _ItemsListWidgetState();
}

class _ItemsListWidgetState extends State<ItemsListWidget> {
  final ListItemBloc _listItemBloc = ListItemBloc();
  Stream<List<ListItem>> stream;

  @override
  void initState() {
    super.initState();
    if (widget.completed) {
      this.stream = _listItemBloc.completedListItems;
    } else {
      this.stream = _listItemBloc.notCompletedListItems;
    }
  }

  @override
  Widget build(BuildContext context) {
    return getListItemsWidget();
  }

  Widget getListItemsWidget() {
    return Container(
        margin: EdgeInsets.only(top: 15),
        child: StreamBuilder<List<ListItem>>(
          stream: this.stream,
          builder:
              (BuildContext context, AsyncSnapshot<List<ListItem>> snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    ListItem listItem = snapshot.data[index];
                    return new ListItemWidget(listItem: listItem);
                  });
            } else if (snapshot.hasError) {
              return Column(children: <Widget>[
                Center(
                  child: Text(Strings.DATA_ERROR),
                )
              ]);
            }
            return Column(
              children: <Widget>[
                Center(
                  child: PlatformCircularProgressIndicator(),
                ),
              ],
            );
          },
        ));
  }

  dispose() {
    // _listItemBloc.dispose();
    super.dispose();
  }
}
