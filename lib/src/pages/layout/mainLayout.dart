import "package:flutter/material.dart";
import "package:sembago/src/functions/mainFunction.dart";
import "package:sembago/src/model/dataContext.dart";
import "package:sembago/src/model/store.dart";
import "package:sembago/src/pages/store/storeList.dart";
import "package:sembago/src/themes/theme.dart";
import "package:sembago/src/widgets/BottomNavigationBar/bottom_navigation_bar.dart";
import 'package:sembago/src/widgets/appBarTop.dart';

class MainLayout extends StatefulWidget {
  MainLayout({Key key, this.data}) : super(key: key);
  final DataContext data;
  @override
  _MainLayoutState createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  //states
  String _user = "";
  String _route = "";
  String _title = "";
  Widget _content = SizedBox.shrink();

  Future<void> initData()async{
    _route = widget.data.route;
    String userMail = widget.data.auth != null? widget.data.auth.email.split("@")[0] : "";    
    if(_route != null){
      if(_route.contains("stores")){
        List<Store> storeList = await AppFunction.storeList();
        setState(() {
          _content = StoreList(stores: storeList);
          _user = userMail;
          _title = "Pilih Toko";
        });
      }
    }    
  }

  @override
  initState(){
    initData().then((result){
      super.initState();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarTop(title:_title, noLeftIcon: true),
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
                            child: _content,
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