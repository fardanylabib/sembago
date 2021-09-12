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
    //using firebase
    return FirebaseClass.sendVerification();
  }

  static Future<List<Store>> storeList(){
    //using firebase
    return FirebaseClass.storeList();
  }

  static Future<Store> createStore({
    String address,
    String name,
    String phone,
    String picture
  }){
    //using firebase
    return FirebaseClass.createStore(
      address: address,
      name: name,
      phone: phone,
      picture: picture
    );
  }
}