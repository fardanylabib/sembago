class Status {
  static const int LOADING = 0;
  static const int SUCCESS = 1;
  static const int ERROR = -1;
}

class Auth {
  static const String WEAK_PASSWORD = 'Password terlalu lemah';
  static const String ACCOUNT_EXIST = 'Email sudah terdaftar';
  static const String SOMETHING_WRONG = 'Ada kesalahan teknis';
  static const String USER_NOT_FOUND = 'Email belum terdaftar, silahkan registrasi dulu';
  static const String WRONG_PASSWORD = 'Password salah';
  static const String INVALID_FIELD = 'Input tidak valid';
}

class StoreStatus{
  static const String STORE_NOT_FOUND = 'Toko tidak ditemukan';
  static const String STORE_CREATION_ERROR = 'Toko gagal dibuat';
  static const String STORE_FIELD_REQUIRED = 'Data isian toko tidak lengkap';
  static const String STORE_EMPLOYEE_FIELD_REQUIRED = 'Data karyawan tidak lengkap';
  static const String STORE_ID_MISMATCH = 'Data toko di device berbeda dengan cloud';  
  static const String INVENTORY_NOT_FOUND = 'Inventory tidak ditemukan';
  static const String INVENTORY_CREATION_ERROR = 'Inventory gagal dibuat';
}

class ProductStatus{
  static const String PRODUCT_FIELD_REQUIRED = 'Data isian produk tidak lengkap';
}

class StorageStatus{
    static const String LOCAL_STORAGE_ERROR = 'Terjadi kesalahan pada penyimpanan';
}