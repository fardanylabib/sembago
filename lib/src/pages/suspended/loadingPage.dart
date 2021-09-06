import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

void main() => runApp(LoadingPage());

class LoadingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: "Loading App", home: Loading());
  }
}

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(vertical: 20),
            alignment: Alignment.center,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Lottie.asset('assets/loading.json',
                      width: 200, fit: BoxFit.fill),
                  Text(
                    'Memulai aplikasi...',
                    style: TextStyle(fontSize: 20, color: Colors.black),
                  ),
                ])),
      ),
    );
  }
}
