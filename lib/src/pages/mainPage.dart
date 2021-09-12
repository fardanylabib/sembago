import 'package:flutter/material.dart';
import 'package:sembago/src/functions/mainFunction.dart';
import 'package:sembago/src/model/auth.dart';
import 'package:sembago/src/model/store.dart';
import 'package:sembago/src/pages/shopping_cart_page.dart';
// import 'package:sembago/src/pages/storeListPage.dart';
import 'package:sembago/src/themes/light_color.dart';
import 'package:sembago/src/themes/theme.dart';
import 'package:sembago/src/widgets/BottomNavigationBar/bottom_navigation_bar.dart';
import 'package:sembago/src/widgets/title_text.dart';
import 'package:sembago/src/widgets/extentions.dart';

class MainPage extends StatefulWidget {
  MainPage({Key key, this.title, this.arguments}) : super(key: key);

  final String title;
  final AuthData arguments;
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  bool isHomePageSelected = true;
  List<Store> _stores = [];
  String _user;
  void initStores()async{
    List<Store> storeList = await AppFunction.storeList();
    setState(() {
      _stores = storeList;
      _user = widget.arguments.email.split("@")[0];
    });
  }

  @override
  initState(){
    initStores();
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

  Widget _title() {
    return Container(
        margin: AppTheme.padding,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TitleText(
                  text: 'Hi ${_user}!',
                  fontSize: 27,
                  fontWeight: FontWeight.w700,
                ),
                TitleText(
                  text: 'Silahkan pilih atau buat toko',
                  fontSize: 20,
                  fontWeight: FontWeight.normal,
                ),
              ],
            ),
            Spacer(),
            !isHomePageSelected
                ? Container(
                    padding: EdgeInsets.all(10),
                    child: Icon(
                      Icons.delete_outline,
                      color: LightColor.orange,
                    ),
                  ).ripple(() {},
                    borderRadius: BorderRadius.all(Radius.circular(13)))
                : SizedBox()
          ],
        ));
  }

  void onBottomIconPressed(int index) {
    if (index == 0 || index == 1) {
      setState(() {
        isHomePageSelected = true;
      });
    } else {
      setState(() {
        isHomePageSelected = false;
      });
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
                    _title(),
                    Expanded(
                      child: AnimatedSwitcher(
                        duration: Duration(milliseconds: 300),
                        switchInCurve: Curves.easeInToLinear,
                        switchOutCurve: Curves.easeOutBack,
                        child: 
                          // isHomePageSelected ? StoreListPage() : 
                          Align(
                            alignment: Alignment.topCenter,
                            child: ShoppingCartPage(),
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
              child: CustomBottomNavigationBar(
                onIconPresedCallback: onBottomIconPressed,
              ),
            )
          ],
        ),
      ),
    );
  }
}