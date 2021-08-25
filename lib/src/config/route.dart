import 'package:flutter/material.dart';
import 'package:sembago/src/pages/mainPage.dart';
import 'package:sembago/src/pages/welcomePage.dart';
import 'package:sembago/src/pages/product_detail.dart';

class Routes {
  static Map<String, WidgetBuilder> getRoute() {
    return <String, WidgetBuilder>{
      '/': (_) => WelcomePage(),
      '/main': (_) => MainPage(),
      '/detail': (_) => ProductDetailPage()
    };
  }
}
