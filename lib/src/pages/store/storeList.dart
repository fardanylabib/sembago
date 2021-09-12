import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sembago/src/model/store.dart';
import 'package:sembago/src/pages/store/newStore.dart';
import 'package:sembago/src/themes/light_color.dart';
import 'package:sembago/src/themes/theme.dart';
import 'package:sembago/src/widgets/buttonBlock.dart';
import 'package:sembago/src/widgets/divider.dart';
import 'package:sembago/src/widgets/title_text.dart';

class StoreList extends StatelessWidget {
  StoreList({Key key, this.stores}) : super(key: key);
  final List<Store> stores;

  Widget _listView() {
    return Container(
      padding: EdgeInsets.only(left:10, right:10, top:10, bottom: 250),
      child: Column(
        children: stores.map((s) => _item(s)).toList()
      )
    );
  }

  Widget _item(Store store) {
    return Container(
      height: 80,
      child: Row(
        children: <Widget>[
          Expanded(
            child: ListTile(
              leading: store.picture == null ? 
              Image.asset("assets/store.png", width: 50, height:50):
              Image.network(store.picture, width: 50, height: 50),
              title: TitleText(
                text: store.name,
                fontSize: 15,
                fontWeight: FontWeight.w700,
              ),
              subtitle: TitleText(
                text: "${store.address}\n${store.phone}",
                fontSize: 12,
                color: Colors.grey,
              ),
              isThreeLine: true,
            )
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          SingleChildScrollView(
            child: stores.length == 0 ? Text("Belum Ada Toko") : _listView(),
          ),
          Positioned(
            bottom:0,
            left: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.only(bottom:100, left: 20, right:20, top:10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Colors.grey.shade200,
                    offset: Offset(2, 4),
                    blurRadius: 5,
                    spreadRadius: 2
                  )
                ],
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xfffbb448), Color(0xffe46b10)]
                )
              ),
              child: Column(
                children: [
                  Text("Toko tidak ada di list?", style: TextStyle(color: Colors.white)),
                  SizedBox(height:10),
                  ButtonBlock(
                    type: ButtonBlock.TYPE_BORDER,
                    onClick: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => NewStore()));
                    },
                    text: "Buat Toko Baru"
                  )
                ],
              ),
            )
          )
        ]
      )
    );
  }
}
