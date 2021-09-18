import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sembago/src/model/dataContext.dart';
import 'package:sembago/src/themes/light_color.dart';
import 'package:sembago/src/themes/theme.dart';
import 'package:sembago/src/widgets/appBarTop.dart';
import 'package:sembago/src/widgets/buttonBlock.dart';
import 'package:sembago/src/widgets/buttonIcon.dart';
import 'package:sembago/src/widgets/entryField.dart';
import './loginPage.dart';
import '../../functions/mainFunction.dart';
import '../../widgets/bezierContainer.dart';
import '../../widgets/alert.dart';
import '../../widgets/loadingOverlay.dart';

class SignUpPage extends StatefulWidget {
  SignUpPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  
  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void processRegister() async{
    final overlay = LoadingOverlay.of(context);
    final result = await overlay.during(AppFunction.registerWithEmailAndPassword(_emailController.text, _passwordController.text));
    if(result.error != null){ 
      Alert.showAlert(context, message:result.error);
      return;
    }
    if(result.email != null && !result.emailVerified){
      showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: Text('Selangkah lagi!'),
          content: Text('Untuk menyelesaikan registrasi, silahkan buka inbox email anda (' +result.email+') lalu klik link verifikasi'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pushNamed(''),
              child: const Text('Tutup'),
            ),
          ],
        ),
      );
      return;
    }
    DataContext data = DataContext(auth: result);
    Navigator.of(context).pushNamed('/stores', arguments: data);
  }

  Widget _loginAccountLabel() {
    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => LoginPage()));
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 20),
        padding: EdgeInsets.all(15),
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Sudah punya akun?',
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              'Masuk',
              style: TextStyle(
                  color: LightColor.orange,
                  fontSize: 13,
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }

  Widget _emailPasswordWidget() {
    return Column(
      children: <Widget>[
        EntryField(title:"Email", controller: _emailController),
        EntryField(title:"Password", isPassword: true, controller: _passwordController),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarTop(title: "Daftar", noUser: true),
      body: Container(
        child: Stack(
          children: <Widget>[
            Positioned(
              bottom: -AppTheme.fullHeight(context) * .3,
              right: -MediaQuery.of(context).size.width * .2,
              child: BezierContainer()
            ),
            Container(
              child: ListView(
                shrinkWrap: true,
                padding: AppTheme.padding,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 30),
                    height: 100,
                    width: 100,
                    color: Colors.transparent,
                    child: SvgPicture.asset('assets/sembago.svg',
                        semanticsLabel: 'Sembago Logo'),
                  ),
                  _emailPasswordWidget(),
                  SizedBox(height: 20),
                  ButtonBlock(text: "Daftar", onClick: processRegister),
                  SizedBox(height: 20),
                  _loginAccountLabel()
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
