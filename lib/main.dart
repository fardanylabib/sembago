import 'package:flutter/material.dart';
import 'package:sembago/src/pages/layout/mainLayout.dart';
import 'package:sembago/src/pages/mainPage.dart';
import 'package:sembago/src/pages/product_detail.dart';
import 'package:sembago/src/widgets/customRoute.dart';
import 'package:sembago/src/pages/preLogin/welcomePage.dart';
import 'package:sembago/src/pages/suspended/loadingPage.dart';
import 'package:sembago/src/pages/suspended/errorPage.dart';
import 'package:sembago/src/functions/mainFunction.dart';
import 'package:sembago/src/helper/constants.dart';
import 'package:google_fonts/google_fonts.dart';

import 'src/themes/theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(App());
}

class App extends StatefulWidget {
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  // Set default `_initialized` and `_error` state to false
  int _status = Status.LOADING;

  // Define an async function to initialize Application functionality
  void initFunctions() async {
    int value = await AppFunction.initialize();
    setState(() {
      _status = value;
    });
  }

  @override
  initState() {
    initFunctions();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Show a loader until FlutterFire is initialized
    if (_status == Status.LOADING) {
      return LoadingPage();
    }
    // Show error message if initialization failed
    if (_status == Status.ERROR) {
      return ErrorPage();
    }
    return AppContainer();
  }
}

class AppContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sembago',
      theme: AppTheme.lightTheme.copyWith(
        textTheme: GoogleFonts.muliTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      debugShowCheckedModeBanner: false,
      // routes: Routes.getRoute(),
      onGenerateRoute: (RouteSettings settings) {
        if (settings.name.contains('main')) {
          return CustomRoute<bool>(
              builder: (BuildContext context) => MainLayout(data:settings.arguments));
        } else if (settings.name.contains('detail')) {
          return CustomRoute<bool>(
              builder: (BuildContext context) => ProductDetailPage());
        } else {
          return CustomRoute<bool>(
              builder: (BuildContext context) => WelcomePage());
        }
      },
      initialRoute: "WelcomePage",
    );
  }
}
