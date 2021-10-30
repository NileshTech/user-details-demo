class UserModel {
  String? email;
  String? firstName;
  String? lastName;
  String? avatar;

  UserModel({this.email, this.firstName, this.lastName, this.avatar});

  factory UserModel.fromJSON(Map map) {
    return UserModel(
        email: map['email'],
        firstName: map['first_name'],
        lastName: map['last_name'],
        avatar: map['avatar']);
  }
}
