class UserData {
  static final UserData _instance = UserData._internal();

  factory UserData() {
    return _instance;
  }

  UserData._internal();

  String? displayName;
  String? email;

  void setUserData(String? name, String? email) async {
    this.displayName = name;
    this.email = email;
  }

  void clearUserData() async {
    this.displayName = null;
    this.email = null;
  }
}
