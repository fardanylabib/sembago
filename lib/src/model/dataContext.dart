import 'package:sembago/src/model/auth.dart';
import 'package:sembago/src/model/store.dart';

class DataContext{
  AuthData auth;
  List<Store> stores;
  Store store;

  String route="";

  DataContext({
    this.auth,
    this.stores,
    this.store,
    this.route
  });
}