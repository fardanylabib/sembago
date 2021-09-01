import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sembago/src/helper/constants.dart';



class FirebaseClass {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
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

  static Future<dynamic> register(email, password) async {
    try {      
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email, 
        password: password
      );
      return userCredential.user.email;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return Auth.WEAK_PASSWORD;
      } else if (e.code == 'email-already-in-use') {
        return Auth.ACCOUNT_EXIST;
      }
    } catch (e) {
      return e.toString();
    }
    return Auth.INVALID_FIELD;
  }

  static Future<dynamic> signIn(email, password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email, 
        password: password
      );
      return userCredential.user.email;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return Auth.USER_NOT_FOUND;
      } else if (e.code == 'wrong-password') {
        return Auth.WRONG_PASSWORD;
      }
    } catch (e) {
      return e.toString();
    }
    return Auth.INVALID_FIELD;
  }
}
