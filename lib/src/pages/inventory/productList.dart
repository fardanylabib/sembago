import 'package:flutter/material.dart';
import 'package:sembago/src/functions/mainFunction.dart';
import 'package:sembago/src/model/inventory.dart';
import 'package:sembago/src/model/store.dart';
import 'package:sembago/src/pages/inventory/newProduct.dart';
import 'package:sembago/src/pages/store/newStore.dart';
import 'package:sembago/src/widgets/alert.dart';
import 'package:sembago/src/widgets/buttonBlock.dart';
import 'package:sembago/src/widgets/title_text.dart';
import '../../widgets/loadingOverlay.dart';

class ProductList extends StatefulWidget {
  ProductList({Key key, this.inventory, this.store}) : super(key: key);
  final Inventory inventory;
  final Store store;

  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {

  void uploadData() async {
    final overlay = LoadingOverlay.of(context);
    final result = await overlay.during(AppFunction.uploadProductList());
    if(result.error != null){ 
      Alert.showAlert(context, message:result.error);
      return;
    }
  }

  Widget _item(Product product) {
    return Container(
      height: 80,
      child: Row(
        children: <Widget>[
          Expanded(
            child: ListTile(
              leading: product.image == null ? 
              Image.asset("assets/product.png", width: 50, height:50):
              Image.network(product.image, width: 50, height: 50),
              title: TitleText(
                text: product.name,
                fontSize: 15,
                fontWeight: FontWeight.w700,
              ),
              subtitle: TitleText(
                text: product.price.toString(),
                fontSize: 12,
                color: Colors.grey,
              ),
              isThreeLine: true,
              trailing: TitleText(
                text: product.category,
                color: Colors.grey,
                fontSize: 12,
              ),
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
            child: Container(
              padding: EdgeInsets.only(left:10, right:10, top:10, bottom: 150),
              alignment: Alignment.center,
              child: widget.inventory.items.length == 0 ? Text("Belum Ada Produk di ${widget.store.name}") :
              Column(
                children: widget.inventory.items.map((s) => _item(s)).toList()
              )
            ),
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
              child: Row(
                children: [
                  ButtonBlock(
                    type: ButtonBlock.TYPE_BORDER,
                    onClick: (){
                      Navigator.push(context,
                        MaterialPageRoute(builder: (context) => NewProduct(inventory: widget.inventory))
                      );
                    },
                    text: "Tambah Produk"
                  ),
                  ButtonBlock(
                    type: ButtonBlock.TYPE_BORDER,
                    onClick: uploadData,
                    text: "Upload Data"
                  ),
                ],
              ),
            )
          )
        ]
      )
    );
  }
}
