import 'package:flutter/material.dart';
import 'package:shopping_list_app/bloc/list_item_bloc.dart';
import 'package:shopping_list_app/model/list_item.dart';
import 'package:shopping_list_app/widgets/list_item_widget.dart';

class ItemsListWidget extends StatefulWidget {
  @override
  _ItemsListWidgetState createState() => _ItemsListWidgetState();
}

class _ItemsListWidgetState extends State<ItemsListWidget> {
  final ListItemBloc _listItemBloc = ListItemBloc();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return getListItemsWidget();
  }

  Future<void> _handleRefresh() async {}

  Widget getListItemsWidget() {
    return StreamBuilder<List<ListItem>>(
      stream: _listItemBloc.listItems,
      builder: (BuildContext context, AsyncSnapshot<List<ListItem>> snapshot) {
         if (snapshot.hasData) {
      for (final item in snapshot.data) {
        print(item.description);
      }
      // return Expanded(
      //   child: RefreshIndicator(
      //     child:
      return Expanded(child:ListView.builder(
        scrollDirection: Axis.vertical,
    shrinkWrap: true,
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                ListItem listItem = snapshot.data[index];
                return new ListItemWidget(listItem: listItem);
              }));
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

  Widget getListItemWidget(AsyncSnapshot<List<ListItem>> snapshot) {
    if (snapshot.hasData) {
      for (final item in snapshot.data) {
        print(item.description);
      }
      return Expanded(
        child: RefreshIndicator(
          child: ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                ListItem listItem = snapshot.data[index];
                return new ListItemWidget(listItem: listItem);
              }),
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
  }

  dispose() {
    _listItemBloc.dispose();
    // super.dispose();
  }
}
