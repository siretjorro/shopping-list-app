import 'dart:async';
import 'package:shopping_list_app/model/list_item.dart';
import 'package:shopping_list_app/repository/list_item_repository.dart';

class ListItemBloc {
  final _listItemRepository = ListItemRepository();
  final _completedListItemController = StreamController<List<ListItem>>.broadcast();
  final _notCompletedListItemController = StreamController<List<ListItem>>.broadcast();


  get completedListItems => _completedListItemController.stream;
  get notCompletedListItems => _notCompletedListItemController.stream;

  ListItemBloc() {
    getCompletedListItems();
    getNotCompletedListItems();
  }

  getCompletedListItems({bool completed}) async {
    //sink is a way of adding data reactively to the stream
    //by registering a new event
    _completedListItemController.sink.add(await _listItemRepository.getCompletedListItems());
  }

  getNotCompletedListItems({bool completed}) async {
    //sink is a way of adding data reactively to the stream
    //by registering a new event
    _notCompletedListItemController.sink.add(await _listItemRepository.getNotCompletedListItems());
  }

  addListItem(ListItem listItem) async {
    await _listItemRepository.createListItem(listItem);
    getNotCompletedListItems();
  }

  updateListItem(ListItem listItem) async {
    await _listItemRepository.updateListItem(listItem);
    getCompletedListItems();
    getNotCompletedListItems();
  }

  deleteListItemById(int id) async {
    await _listItemRepository.deleteListItemById(id);
    getCompletedListItems();
    getNotCompletedListItems();
  }

  dispose() {
    _completedListItemController.close();
    _notCompletedListItemController.close();
  }
}