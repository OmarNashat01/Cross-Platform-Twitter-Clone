class UserModel {
  String name;
  String email;
  DateTime dob;

  UserModel({
    required this.name,
    required this.email,
    required this.dob,
  });

  void save() {
    print(name);
    print(email);
    print(dob);
  }
}
