import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sembago/src/helper/constants.dart';
import 'package:sembago/src/model/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/store.dart';

class FirebaseClass {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
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

  static Future<AuthData> register(email, password) async {
    try {      
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email, 
        password: password
      );
      await userCredential.user.sendEmailVerification();
      String idToken = await userCredential.user.getIdToken();
      return AuthData(
        email: userCredential.user.email,
        fullName: userCredential.user.displayName,
        userName: userCredential.additionalUserInfo.username,
        refreshToken: userCredential.user.refreshToken,
        emailVerified: userCredential.user.emailVerified,
        token: idToken
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return AuthData(
          error: Auth.WEAK_PASSWORD
        );
      } else if (e.code == 'email-already-in-use') {
        return AuthData(
          error: Auth.ACCOUNT_EXIST
        );
      }
    } catch (e) {
      return AuthData(
        error: e.toString()
      );
    }
    return AuthData(
        error: Auth.INVALID_FIELD
    );
  }

  static Future<AuthData> signIn(email, password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email, 
        password: password
      );
      String idToken = await userCredential.user.getIdToken();
      return AuthData(
        email: userCredential.user.email,
        fullName: userCredential.user.displayName,
        userName: userCredential.additionalUserInfo.username,
        refreshToken: userCredential.user.refreshToken,
        emailVerified: userCredential.user.emailVerified,
        token: idToken
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return AuthData(
          error: Auth.USER_NOT_FOUND
        );
      } else if (e.code == 'wrong-password') {
        return AuthData(
          error: Auth.WRONG_PASSWORD
        );
      }
    } catch (e) {
      return AuthData(
        error: e.toString()
      );
    }
    return AuthData(
        error: Auth.INVALID_FIELD
    );
  }

  static Future<AuthData> sendVerification() async {
    try{
      User user = FirebaseAuth.instance.currentUser;
      if (user!= null && !user.emailVerified) {
        await user.sendEmailVerification();
        return AuthData(
          email: user.email,
          verificationSent: true
        );
      }
    } catch (e) {
      return AuthData(
        error: e.toString()
      );
    }
    return AuthData(
        error: Auth.USER_NOT_FOUND
    );
  }

  static Future<List<Store>> storeList() async{
    CollectionReference stores = _firestore.collection('store');
    QuerySnapshot query = await stores.get();
    return query.docs.map((doc) {
      return Store.fromJson(doc.data());
    }).toList();
  }

  static Future<dynamic> createStore({
    String address,
    String name,
    String phone,
    String picture
  }) async{
    try{
      Map<String, dynamic> data = Store(
        address:address,
        name: name,
        phone: phone,
        picture: picture
      ).toJson();
      DocumentReference newStore =  await _firestore.collection('store').add(data);
      if(newStore.id != null){
        DocumentSnapshot storeDoc = await newStore.get();
        return Store.fromJson(storeDoc.data());
      }
      return StoreStatus.STORE_NOT_FOUND;
    }catch(e){
      String errorMsg = e.toString();
      return "${StoreStatus.STORE_CREATION_ERROR} | $errorMsg";
    }
  }
}
