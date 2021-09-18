import 'package:localstorage/localstorage.dart';
import 'package:sembago/src/helper/constants.dart';
import 'package:sembago/src/model/auth.dart';
import 'package:sembago/src/model/dataContext.dart';
import 'package:sembago/src/model/inventory.dart';
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

  static Future<Inventory> updateStoreInventory({
    String storeID,
    List<String> categories,
    List<Product> items,
    DateTime lastUpdated
  })async{
    Inventory inventory = Inventory(
      categories: categories,
      storeID: storeID,
      items: items,
      lastUpdated: lastUpdated == null ? DateTime.now() : lastUpdated
    );
    //using firebase
    bool isSuccess = await FirebaseClass.updateStoreInventory(inventory);
    if(!isSuccess){
      return null;
    }
    return inventory;
  }

  static Future<DataContext> getAndSyncStoreInventory(String storeID)async{
    final LocalStorage storage = new LocalStorage("inventory");
    final isStorageReady = await storage.ready;
    if(!isStorageReady){
      return DataContext(error: StorageStatus.LOCAL_STORAGE_ERROR); 
    }
    String localStoreID = storage.getItem("storeID");
    List<Map<String, dynamic>> localItemsJson = storage.getItem("items");
    String localDateStr = storage.getItem("lastUpdated");
    List<String> categories = storage.getItem("categories");
    DateTime localDate = localDateStr == null ? null : DateTime.parse(localDateStr);

    if(storeID != null && localStoreID != null && storeID != localStoreID){
      return DataContext(error: StoreStatus.STORE_ID_MISMATCH);
    }
    //using firebase
    Inventory cloudInventory = await FirebaseClass.getStoreInventory(storeID);
    if(cloudInventory != null){
      if(localStoreID != null && localItemsJson != null && localDate.isAfter(cloudInventory.lastUpdated)){ 
        //localstorage contains inventory & newer
        //push local data to cloud
        final inventory = await updateStoreInventory(
          storeID: storeID,
          lastUpdated: localDate,
          categories: categories,
          items: localItemsJson.map((it) => Product.fromJson(it)).toList()
        );
        return DataContext(inventory: inventory);
      }else{
        //set local data with cloud data
        await storage.setItem("storeID", cloudInventory.storeID);
        await storage.setItem("categories", cloudInventory.categories);
        await storage.setItem("items", cloudInventory.items.map((it)=>it.toJson()).toList());
        await storage.setItem("lastUpdated", cloudInventory.lastUpdated.toIso8601String());
        return DataContext(inventory: cloudInventory);
      }
    }else if(localStoreID != null && localItemsJson != null ){
      //maybe connection error just get local data
      return DataContext(
        inventory: Inventory(
          storeID: storage.getItem("storeID"),
          categories: storage.getItem("categories"),
          items: localItemsJson.map((it) => Product.fromJson(it)).toList(),
          lastUpdated: localDate
        )
      );
    }else{
      return DataContext(error: StoreStatus.STORE_NOT_FOUND);
    }
  }

  static Future<DataContext> createStore({
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
      return DataContext(error: StoreStatus.STORE_FIELD_REQUIRED);
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
      return DataContext(error: StoreStatus.STORE_EMPLOYEE_FIELD_REQUIRED);
    }
    //add employee with current user
    employees.add(Employee(
      email: userAuth.email,
      name: userAuth.fullName
    ));
    //using firebase
    var result = await FirebaseClass.createStore(
      Store(
        address: address,
        name: name,
        phone: phone,
        picture: picture,
        employees: employees
      )
    );
    if(result.runtimeType == String){ 
      return DataContext(error: result);
    }
    final storeResult = result as Store;
    result = await FirebaseClass.createInventory(
      Inventory(
        categories: [],
        storeID: storeResult.id,
        items: [],
        lastUpdated: DateTime.now()
      )
    );
    if(result.runtimeType == String){ 
      return DataContext(error: result);
    }
    return DataContext(
      inventory: result as Inventory,
      store: storeResult
    );
  }

  static Future<dynamic> addProduct({
    String category,
    String name,
    String code,
    double price,
    String image,
    Inventory inventory
  }) async{
      List<Product> items = [];
      if(inventory == null){ //no inventory loaded
        final LocalStorage storage = new LocalStorage("inventory");
        final isStorageReady = await storage.ready;
        if(!isStorageReady){
          return null;
        }
        List<String> categories = [];
        List<Map<String, dynamic>> itemsJson = [];
        if(storage.getItem("storeID") == null){
          storage.setItem("storeID", inventory.storeID);
          storage.setItem("categories", categories);
        }else{
          categories = storage.getItem("categories");
          itemsJson = storage.getItem("items");
          items = itemsJson.map((it) => Product.fromJson(it)).toList();
        }
        //appdend new product to items
        items.add(Product(
          category: category,
          name: name,
          code: code,
          price: price,
          image: image
        ));
        itemsJson = items.map((it) => it.toJson()).toList();
        storage.setItem("items", itemsJson);
      }else{//inventory loaded

      }
  }
    // storage.setItem("items", categories);
    // try{
    //   Map<String, dynamic> data = Product(
    //     name: name,
    //     category: categeory,
    //     code: code,
    //     price: price
    //   ).toJson();

    //   if(inventory == null){
        
    //   }
    //   DocumentReference newProduct =  await _firestore.collection('store').add(data);
    //   if(newStore.id != null){
    //     DocumentSnapshot storeDoc = await newStore.get();
    //     return Store.fromJson(storeDoc.data());
    //   }
    //   return StoreStatus.STORE_NOT_FOUND;
    // }catch(e){
    //   String errorMsg = e.toString();
    //   return "${StoreStatus.STORE_CREATION_ERROR} | $errorMsg";
    // }
}