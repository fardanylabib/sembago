import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:sembago/src/model/dataContext.dart';
import 'package:sembago/src/model/inventory.dart';
import 'package:sembago/src/model/store.dart';
import 'package:sembago/src/themes/theme.dart';
import 'package:sembago/src/widgets/appBarTop.dart';
import 'package:sembago/src/widgets/buttonBlock.dart';
import 'package:sembago/src/widgets/buttonIcon.dart';
import 'package:sembago/src/widgets/entryField.dart';
import 'package:sembago/src/widgets/entryFieldDropdown.dart';
import '../../functions/mainFunction.dart';
import '../../widgets/bezierContainer.dart';
import '../../widgets/alert.dart';
import '../../widgets/loadingOverlay.dart';

class NewProduct extends StatefulWidget {
  NewProduct({Key key, this.title, this.inventory}) : super(key: key);

  final String title;
  final Inventory inventory;

  @override
  _NewProductState createState() => _NewProductState();
}

class _NewProductState extends State<NewProduct> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _codeController = TextEditingController();
  
  String _selectedCategory = "";

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _priceController.dispose();
    _nameController.dispose();
    _codeController.dispose();
    super.dispose();
  }

  void addProduct() async{
    String name = _nameController.text;
    double price = double.parse(_priceController.text);
    String category = _selectedCategory;
    String code = _codeController.text;

    final overlay = LoadingOverlay.of(context);
    final result = await overlay.during(AppFunction.addProductOffline(
      name: name,
      price: price,
      category: category,
      code: code,
      inventory: widget.inventory
    ));
    if(result.error != null){ 
      Alert.showAlert(context, message:result.error);
      return;
    }
    final data = DataContext(inventory: result.inventory, route: "/inventory");
    Navigator.of(context).pushNamed("/main", arguments: data);
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBarTop(
        title: "Isi Data Produk"
      ),
      body: Container(
        height: height,
        child: Stack(
          children: <Widget>[
            Positioned(
              bottom: -AppTheme.fullHeight(context) * .3,
              right: -MediaQuery.of(context).size.width * .2,
              child: BezierContainer()
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: 30),
                    EntryField(title:"Nama Produk", controller: _nameController),
                    EntryField(title:"Kode Produk", controller: _codeController),
                    EntryField(title:"Harga", controller: _priceController),
                    EntryFieldDropdown(
                      title:"Kategori",
                      hint: "Pilih kategori",
                      selected: _selectedCategory,
                      items: widget.inventory.categories,
                      onChanged: (item){
                        setState(() {_selectedCategory = item;});
                      }
                    ),
                    SizedBox(height: 30),
                    ButtonBlock(text: "Simpan Produk", onClick: addProduct),
                    SizedBox(height: 30),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}


class EmployeeFormController {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
}