import "package:flutter/material.dart";
import "package:sembago/src/functions/mainFunction.dart";
import "package:sembago/src/model/auth.dart";
import "package:sembago/src/model/dataContext.dart";
import "package:sembago/src/model/store.dart";
import "package:sembago/src/pages/shopping_cart_page.dart";
import "package:sembago/src/pages/store/storeList.dart";
import "package:sembago/src/themes/light_color.dart";
import "package:sembago/src/themes/theme.dart";
import "package:sembago/src/widgets/BottomNavigationBar/bottom_navigation_bar.dart";
import 'package:sembago/src/widgets/appBarTop.dart';
import 'package:sembago/src/widgets/buttonIcon.dart';
import "package:sembago/src/widgets/title_text.dart";
import "package:sembago/src/widgets/extentions.dart";

class MainLayout extends StatefulWidget {
  MainLayout({Key key, this.title, this.data}) : super(key: key);

  final String title;
  final DataContext data;
  @override
  _MainLayoutState createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {

  //states
  List<Store> _stores = [];
  String _user;
  String _route;
  void initData()async{
    List<Store> storeList = await AppFunction.storeList();
    String userMail = widget.data.auth != null? widget.data.auth.email.split("@")[0] : "";    
    setState(() {
      storeList.add(storeList[0]);
    storeList.add(storeList[0]);
    storeList.add(storeList[0]);
    storeList.add(storeList[0]);
    storeList.add(storeList[0]);
    storeList.add(storeList[0]);
    storeList.add(storeList[0]);
    storeList.add(storeList[0]);
      _stores = storeList;
      _user = userMail;
      _route = widget.data.route;
    });
  }

  @override
  initState(){
    initData();
    super.initState();
  }

  String _title(){
    String text = "";
    if(_route != null){
      if(_route.contains("stores")){
        text = "Pilih Toko";
      }else if(_route.contains("transaction")){
        text = "Transaksi";
      }else if(_route.contains("management")){
        text = "Manajemen Data";
      }
    }
    return text;
  }

  Widget _content(){
    if(_route == null){
      return null;
    }
    if(_route.contains("stores")){
      return StoreList(stores:  _stores);
    }else if(_route.contains("transaction")){
      
      return StoreList(stores:  _stores);
    }else if(_route.contains("management")){

      return StoreList(stores:  _stores);
    }else{
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarTop(title:_title(), noLeftIcon: true),
      body: SafeArea(
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            SingleChildScrollView(
              child: Container(
                height: AppTheme.fullHeight(context) - 50,
                decoration: AppTheme.mainBackground(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      child: AnimatedSwitcher(
                        duration: Duration(milliseconds: 300),
                        switchInCurve: Curves.easeInToLinear,
                        switchOutCurve: Curves.easeOutBack,
                        child: 
                          Align(
                            alignment: Alignment.topCenter,
                            child: _content(),
                          ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: CustomBottomNavigationBar(),
            )
          ],
        ),
      ),
    );
  }
}