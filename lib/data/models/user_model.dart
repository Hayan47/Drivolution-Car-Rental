class User {
  int? userid;
  String? username;
  String? email;
  String? password;
  String? phoneNumper;
  int? age;

  User(
      {this.userid,
      this.username,
      this.email,
      this.password,
      this.phoneNumper,
      this.age});

  User.fromJson(Map<String, dynamic> json) {
    userid = json['userid'];
    username = json['username'];
    email = json['email'];
    password = json['password'];
    phoneNumper = json['phoneNumper'];
    age = json['age'];
  }
}
