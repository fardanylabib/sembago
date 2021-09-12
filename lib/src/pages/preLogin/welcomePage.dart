import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sembago/src/widgets/buttonBlock.dart';
import './loginPage.dart';
import './signupPage.dart';

class WelcomePage extends StatefulWidget {
  WelcomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  Widget _signInButton() {
    return ButtonBlock(
      type: ButtonBlock.TYPE_WHITE,
      text: "Masuk",
      onClick: (){
        Navigator.push(
          context, 
          MaterialPageRoute(builder: (context) => LoginPage())
        );
      },
    );
  }

  Widget _signUpButton() {
    return ButtonBlock(
      type: ButtonBlock.TYPE_BORDER,
      text: "Daftar Baru",
      onClick: (){
        Navigator.push(
          context, 
          MaterialPageRoute(builder: (context) => SignUpPage())
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Colors.grey.shade200,
                    offset: Offset(2, 4),
                    blurRadius: 5,
                    spreadRadius: 2)
              ],
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xfffbb448), Color(0xffe46b10)])),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SvgPicture.asset('assets/sembago-white.svg',
                  semanticsLabel: 'Sembago Logo'),
              SizedBox(
                height: 80,
              ),
              _signInButton(),
              SizedBox(
                height: 20,
              ),
              _signUpButton(),
            ],
          ),
        ),
      ),
    );
  }
}
