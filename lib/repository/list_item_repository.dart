import 'package:shopping_list_app/model/list_item.dart';
import 'package:shopping_list_app/provider/api_provider.dart';

class ListItemRepository {
  final _apiProvider = ApiProvider();

  Future<List<ListItem>> getCompletedListItems() => _apiProvider.getListItems(true);

  Future<List<ListItem>> getNotCompletedListItems() => _apiProvider.getListItems(false);

  Future<ListItem> createListItem(ListItem listItem) => _apiProvider.createListItem(listItem);

  Future<void> updateListItem(ListItem listItem) => _apiProvider.updateListItem(listItem);

  Future deleteListItemById(int id) => _apiProvider.deleteListItemById(id);
}