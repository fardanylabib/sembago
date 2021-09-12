import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sembago/src/model/dataContext.dart';
import 'package:sembago/src/model/store.dart';
import 'package:sembago/src/themes/theme.dart';
import 'package:sembago/src/widgets/appBarTop.dart';
import 'package:sembago/src/widgets/buttonBlock.dart';
import 'package:sembago/src/widgets/buttonIcon.dart';
import '../../functions/mainFunction.dart';
import '../../widgets/bezierContainer.dart';
import '../../widgets/alert.dart';
import '../../widgets/loadingOverlay.dart';

class NewStore extends StatefulWidget {
  NewStore({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _NewStoreState createState() => _NewStoreState();
}

class _NewStoreState extends State<NewStore> {
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  List<EmployeeFormController> _employeeFormController = [];
  
  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _addressController.dispose();
    _nameController.dispose();
    _phoneController.dispose();
    _employeeFormController.forEach((form) { 
      form.emailController.dispose();
      form.nameController.dispose();
    });
    super.dispose();
  }

  void addStore() async{
    String name = _nameController.text;
    String address = _addressController.text;
    String phone = _phoneController.text;
    List<Employee> employees = _employeeFormController.map((form){
      return Employee(
        email: form.emailController.text,
        name: form.nameController.text
      );
    }).toList();
    final overlay = LoadingOverlay.of(context);
    final result = await overlay.during(AppFunction.createStore(
      address: address,
      name: name,
      phone: phone,
      employees: employees
    ));
    if(result.runtimeType == String){ 
      Alert.showAlert(context, message:result);
      return;
    }
    
    DataContext data = DataContext(store: result);
    // Navigator.of(context).pushNamed('/stores', arguments: data);
  }

  Widget _entryField({
      String title,
      TextEditingController controller,
      bool isPassword = false
    }) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
              controller: controller,
              obscureText: isPassword,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  fillColor: Color(0xfff3f3f4),
                  filled: true
              )
          )
        ],
      ),
    );
  }

  Widget _employeeAddButton() {
    return InkWell(
      onTap: () {
        //add employee form
        setState(() {
          _employeeFormController.add(EmployeeFormController());
          _employeeFormController = _employeeFormController;
        });
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 5),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            color: Colors.white,
            border: Border.all(color: Colors.orange, width: 2), 
        ),
        child: Text(
          '+ Tambah Karyawan',
          style: TextStyle(fontSize: 20, color: Colors.orange),
        ),
      ),
    );
  }

  Widget _employeeForm(){
    if(_employeeFormController.length < 1){
      return SizedBox(height: 5);
    }
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(15),
      margin: EdgeInsets.only(bottom: 10),
      alignment: Alignment.topLeft,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          color: Colors.transparent,
          border: Border.all(color: Colors.grey, width: 1), 
      ),
      child: Column(
        children: _employeeFormController.map((cont){
          return Column(
            children: <Widget>[
              Container(
                alignment: Alignment.centerRight,
                child: ButtonIcon(
                  icon: Icons.delete_outline,
                  onClick: (){
                    setState(() {
                      _employeeFormController.removeAt(_employeeFormController.indexOf(cont));
                      _employeeFormController = _employeeFormController;
                    });
                  }
                )
              ),
              _entryField(title:"Nama", controller: cont.nameController),
              _entryField(title:"Email", controller: cont.emailController),
              SizedBox(height:20)
            ],
          );
        }).toList()
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBarTop(
        title: "Isi Data Toko"
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
                    _entryField(title:"Nama Toko", controller: _nameController),
                    _entryField(title:"Alamat", controller: _addressController),
                    _entryField(title:"No.Telepon", controller: _phoneController),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text("Karyawan", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
                      margin: EdgeInsets.only(top: 30, bottom: 15),
                    ),
                    _employeeForm(),
                    _employeeAddButton(),
                    SizedBox(height: 30),
                    ButtonBlock(text: "Buat Toko", onClick: addStore),
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