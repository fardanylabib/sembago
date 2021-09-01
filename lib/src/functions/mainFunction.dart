import './firebase.dart';

class AppFunction{
  static Future<int> initialize(){
    //using firebase
    return FirebaseClass.initFirebase();
  }

  static Future registerWithEmailAndPassword(String email, String password){
    //using firebase
    return FirebaseClass.register(email, password);
  }

  static Future signInWithEmailAndPassword(String email, String password){
    //using firebase
    return FirebaseClass.signIn(email, password);
  }
}