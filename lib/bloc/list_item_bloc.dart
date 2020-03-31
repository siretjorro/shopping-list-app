import 'dart:async';
import 'package:shopping_list_app/model/list_item.dart';
import 'package:shopping_list_app/repository/list_item_repository.dart';

class ListItemBloc {
  final _listItemRepository = ListItemRepository();
  final _listItemController = StreamController<List<ListItem>>.broadcast();

  get listItems => _listItemController.stream;

  ListItemBloc() {
    getListItems();
  }

  getListItems({bool completed}) async {
    //sink is a way of adding data reactively to the stream
    //by registering a new event
    print("bloc method");
    _listItemController.sink.add(await _listItemRepository.getAllListItems(completed: completed));
  }

  addListItem(ListItem listItem) async {
    await _listItemRepository.createListItem(listItem);
    getListItems();
  }

  updateListItem(ListItem listItem) async {
    await _listItemRepository.updateListItem(listItem);
    getListItems();
  }

  deleteListItemById(int id) async {
    await _listItemRepository.deleteListItemById(id);
    getListItems();
  }

  dispose() {
    _listItemController.close();
  }
}