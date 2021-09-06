import 'package:flutter/material.dart';
import 'package:sembago/src/functions/mainFunction.dart';
import 'package:sembago/src/model/auth.dart';
import 'package:sembago/src/model/dataContext.dart';
import 'package:sembago/src/model/store.dart';
import 'package:sembago/src/pages/shopping_cart_page.dart';
import 'package:sembago/src/pages/store/storeList.dart';
import 'package:sembago/src/themes/light_color.dart';
import 'package:sembago/src/themes/theme.dart';
import 'package:sembago/src/widgets/BottomNavigationBar/bottom_navigation_bar.dart';
import 'package:sembago/src/widgets/title_text.dart';
import 'package:sembago/src/widgets/extentions.dart';

class MainLayout extends StatefulWidget {
  MainLayout({Key key, this.title, this.data}) : super(key: key);

  final String title;
  final DataContext data;
  @override
  _MainLayoutState createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  
  //states
  Iterable<Store> _stores = [];
  String _user;
  String _route;

  void initData()async{
    Iterable<Store> storeList = await AppFunction.storeList();
    String userMail = widget.data.auth != null? widget.data.auth.email.split("@")[0] : "";
    setState(() {
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

  Widget _appBar() {
    return Container(
      padding: AppTheme.padding,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          RotatedBox(
            quarterTurns: 4,
            child: _icon(Icons.sort, color: Colors.black54),
          ),
          ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(13)),
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).backgroundColor,
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      color: Color(0xfff8f8f8),
                      blurRadius: 10,
                      spreadRadius: 10),
                ],
              ),
              child: Image.asset("assets/user.png"),
            ),
          ).ripple(() {}, borderRadius: BorderRadius.all(Radius.circular(13)))
        ],
      ),
    );
  }

  Widget _icon(IconData icon, {Color color = LightColor.iconColor}) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(13)),
          color: Theme.of(context).backgroundColor,
          boxShadow: AppTheme.shadow),
      child: Icon(
        icon,
        color: color,
      ),
    ).ripple(() {}, borderRadius: BorderRadius.all(Radius.circular(13)));
  }


  Widget _content(){
    if(_route == null){
      return null;
    }
    if(_route.contains('stores')){
      return StoreList(stores:  _stores);
    }else if(_route.contains('transaction')){
      
      return StoreList(stores:  _stores);
    }else if(_route.contains('management')){

      return StoreList(stores:  _stores);
    }else{
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            SingleChildScrollView(
              child: Container(
                height: AppTheme.fullHeight(context) - 50,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xfffbfbfb),
                      Color(0xfff7f7f7),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    _appBar(),
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