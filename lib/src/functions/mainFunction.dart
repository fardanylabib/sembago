import 'package:sembago/src/model/auth.dart';
import '../model/store.dart';
import './firebase.dart';

class AppFunction{
  static Future<int> initialize(){
    //using firebase
    return FirebaseClass.initFirebase();
  }

  static Future<AuthData> registerWithEmailAndPassword(String email, String password){
    //using firebase
    return FirebaseClass.register(email, password);
  }

  static Future<AuthData> signInWithEmailAndPassword(String email, String password){
    //using firebase
    return FirebaseClass.signIn(email, password);
  }

  static Future<AuthData> sendEmailVerification(){
    return FirebaseClass.sendVerification();
  }

  static Future<Iterable<Store>> storeList(){
    return FirebaseClass.storeList();
  }
}