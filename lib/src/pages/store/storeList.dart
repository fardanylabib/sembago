import 'package:flutter/material.dart';
import 'package:sembago/src/model/store.dart';
import 'package:sembago/src/themes/theme.dart';
import 'package:sembago/src/widgets/title_text.dart';

class StoreList extends StatelessWidget {
  StoreList({Key key, this.stores}) : super(key: key);
  final Iterable<Store> stores;

  Widget _listView() {
    return Column(children: stores.map((s) => _item(s)).toList());
  }

  Widget _item(Store store) {
    return Container(
      height: 80,
      child: Row(
        children: <Widget>[
          Expanded(
            child: ListTile(
              title: TitleText(
                text: store.name,
                fontSize: 15,
                fontWeight: FontWeight.w700,
              ),
              subtitle: TitleText(
                text: "${store.address}\n${store.phone}",
                fontSize: 14,
              ),
              isThreeLine: true,
            )
          )
        ],
      ),
    );
  }

  Widget _addNewButton(BuildContext context) {
    return InkWell(
      onTap: () {
        // Navigator.push(
        //   context, MaterialPageRoute(builder: (context) => LoginPage())
        // );
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 13),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Color(0xffdf8e33).withAlpha(100),
                  offset: Offset(2, 4),
                  blurRadius: 8,
                  spreadRadius: 2)
            ],
            color: Colors.white),
        child: Text(
          'Buat Toko Baru',
          style: TextStyle(fontSize: 20, color: Color(0xfff7892b)),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AppTheme.padding,
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            _listView(),
            Divider(
              thickness: 1,
              height: 70,
            ),
            SizedBox(height: 30),
            _addNewButton(context),
          ],
        ),
      ),
    );
  }
}
