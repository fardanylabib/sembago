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
