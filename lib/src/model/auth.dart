class AuthData {
  String email;
  String userName;
  String fullName;
  String token;
  String refreshToken;
  String photoUrl;
  bool verificationSent = false;
  bool emailVerified = false;
  String error;
  AuthData({
    this.email,
    this.userName,
    this.fullName,
    this.token,
    this.emailVerified,
    this.refreshToken,
    this.verificationSent,
    this.photoUrl,
    this.error
  });
}