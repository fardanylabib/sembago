import "package:flutter/material.dart";
import "package:flutter_svg/flutter_svg.dart";
import "package:sembago/src/model/dataContext.dart";
import 'package:sembago/src/themes/light_color.dart';
import 'package:sembago/src/themes/theme.dart';
import 'package:sembago/src/widgets/appBarTop.dart';
import 'package:sembago/src/widgets/buttonBlock.dart';
import 'package:sembago/src/widgets/buttonIcon.dart';
import "./signupPage.dart";
import "../../functions/mainFunction.dart";
import "../../widgets/bezierContainer.dart";
import "../../widgets/alert.dart";
import "../../widgets/loadingOverlay.dart";
import "../../widgets/divider.dart";

class LoginPage extends StatefulWidget {
  LoginPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  
  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
  
  void processSignIn() async{
    final overlay = LoadingOverlay.of(context);
    final result = await overlay.during(AppFunction.signInWithEmailAndPassword(_emailController.text, _passwordController.text));
    if(result.error != null){ 
      Alert.showAlert(context, message:result.error);
      return;
    }
    if(result.email != null && !result.emailVerified){
      showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: Text("Email belum diverifikasi"),
          content: Text("Silahkan buka inbox email anda (" +result.email+") lalu klik link verifikasi"),
          actions: <Widget>[
            TextButton(
              onPressed: () => resendVerification(),
              child: const Text("Kirim Link Lagi"),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Tutup"),
            ),
          ],
        ),
      );
      return;
    }
    DataContext data = DataContext(auth: result, route: "/stores");
    Navigator.of(context).pushNamed("/main", arguments: data);
  }

  void resendVerification() async {
    Navigator.pop(context);
    final overlay = LoadingOverlay.of(context);
    final result = await overlay.during(AppFunction.sendEmailVerification());
    if(result.verificationSent){
      showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: Text("Link verifikasi terkirim"),
          content: Text("Silahkan buka inbox email anda (" +result.email+") lalu klik link verifikasi"),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Tutup"),
            ),
          ],
        ),
      );
    }
  }

  Widget _entryField({
    String title,
    TextEditingController controller,
    bool isPassword = false
  }) {
      return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
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
                  filled: true))
        ],
      ),
    );
  }

  Widget _facebookButton() {
    return Container(
      height: 50,
      margin: EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xff1959a9),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(5),
                    topLeft: Radius.circular(5)),
              ),
              alignment: Alignment.center,
              child: Text("f",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.w400)),
            ),
          ),
          Expanded(
            flex: 5,
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xff2872ba),
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(5),
                    topRight: Radius.circular(5)),
              ),
              alignment: Alignment.center,
              child: Text("Masuk dengan Facebook",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w400)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _createAccountLabel() {
    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => SignUpPage()));
      },
      child: Container(
        padding: EdgeInsets.all(15),
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Belum punya akun?",
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              "Daftar",
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
        _entryField(title:"Email", controller: _emailController),
        _entryField(title:"Password", isPassword: true, controller: _passwordController),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarTop(title: "Masuk", noUser: true),
      body: Container(
        child: Stack(
          children: <Widget>[
            Positioned(
              bottom: -AppTheme.fullHeight(context) * .3,
              right: -MediaQuery.of(context).size.width * .2,
              child: BezierContainer()
            ),
            Center(
              child:ListView(
                // reverse: true,
                shrinkWrap: true,
                padding: AppTheme.padding,
                children: <Widget>[
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 30),
                      height: 100,
                      width: 100,
                      color: Colors.transparent,
                      child: SvgPicture.asset("assets/sembago.svg",
                          semanticsLabel: "Sembago Logo"),
                    ),
                    _emailPasswordWidget(),
                    SizedBox(height: 20),
                    ButtonBlock(text: "Masuk", onClick: processSignIn),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      alignment: Alignment.centerRight,
                      child: Text("Lupa Password ?", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
                    ),
                    DividerH(text:"atau"),
                    _facebookButton(),
                    _createAccountLabel(),
                  ],
              )
            )
          ],
        )
      )
    );
    // return Scaffold(
    //   body: Container(
    //     height: height,
    //     child: Stack(
    //       children: <Widget>[
    //         Positioned(
    //             top: -height * .15,
    //             right: -MediaQuery.of(context).size.width * .4,
    //             child: BezierContainer()),
    //         Container(
    //           padding: EdgeInsets.symmetric(horizontal: 20),
    //           child: SingleChildScrollView(
    //             child: 
    //           ),
    //         ),
    //       ],
    //     ),
    //   )
    // );
  }
}
