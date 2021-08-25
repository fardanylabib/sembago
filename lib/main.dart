import 'package:flutter/material.dart';
import 'package:sembago/src/config/route.dart';
import 'package:sembago/src/pages/mainPage.dart';
import 'package:sembago/src/pages/product_detail.dart';
import 'package:sembago/src/widgets/customRoute.dart';
import 'package:sembago/src/pages/welcomePage.dart';
import 'package:sembago/src/pages/loadingPage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';

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
  bool _initialized = false;
  bool _error = false;

  // Define an async function to initialize FlutterFire
  void initializeFlutterFire() async {
    try {
      // Wait for Firebase to initialize and set `_initialized` state to true
      await Firebase.initializeApp();
      setState(() {
        _initialized = true;
      });
    } catch (e) {
      // Set `_error` state to true if Firebase initialization fails
      setState(() {
        _error = true;
      });
    }
  }

  @override
  void initState() {
    initializeFlutterFire();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Show error message if initialization failed
    // if (_error == true) {
    //   return SnackBar(
    //     content: const Text('Firebase initialization failed!'),
    //   );
    // }

    // Show a loader until FlutterFire is initialized
    if (_initialized == false) {
      return LoadingPage();
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
      routes: Routes.getRoute(),
      onGenerateRoute: (RouteSettings settings) {
        if (settings.name.contains('main')) {
          return CustomRoute<bool>(
              builder: (BuildContext context) => MainPage());
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
