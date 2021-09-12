import 'package:sembago/src/helper/constants.dart';
import 'package:sembago/src/model/auth.dart';
import '../model/store.dart';
import './firebase.dart';

class AppFunction{
  static AuthData userAuth;

  static void setAauthData(AuthData uAuth){
    userAuth = uAuth;
  }

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

  static Future<dynamic> createStore({
    String address,
    String name,
    String phone,
    String picture,
    List<Employee> employees
  })async{
    if(
      address == null || address.length < 1 ||
      name == null || name.length < 1 ||
      phone == null || phone.length < 1
    ){
      return StoreStatus.STORE_FIELD_REQUIRED;
    }
    if(
      employees != null && employees.length > 0 &&
      employees.any((emp){
        if(emp.email == null || emp.name == null || emp.email.length < 1 || emp.name.length < 1){
          return true;
        }
        return false;
      })
    ){
      return StoreStatus.STORE_EMPLOYEE_FIELD_REQUIRED;
    }
    //add employee with current user
    employees.add(Employee(
      email: userAuth.email,
      name: userAuth.fullName
    ));
    //using firebase
    return FirebaseClass.createStore(
      address: address,
      name: name,
      phone: phone,
      picture: picture,
      employees: employees
    );
  }
}