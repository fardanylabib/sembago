import 'package:sembago/src/model/auth.dart';
import 'package:sembago/src/model/inventory.dart';
import 'package:sembago/src/model/store.dart';

class DataContext{
  AuthData auth;
  List<Store> stores;
  Store store;
  Inventory inventory;
  String route="";
  String error = "";

  DataContext({
    this.auth,
    this.stores,
    this.store,
    this.route,
    this.inventory,
    this.error
  });
}