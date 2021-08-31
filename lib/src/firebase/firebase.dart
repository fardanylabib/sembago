import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sembago/src/helper/constants.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class FirebaseClass {
  // Define an async function to initialize FlutterFire
  static Future<int> initFirebase() async {
    try {
      // Wait for Firebase to initialize and set `_initialized` state to true
      await Firebase.initializeApp();
      return Status.SUCCESS;
    } catch (e) {
      // Set `_error` state to true if Firebase initialization fails
      return Status.ERROR;
    }
  }
}
