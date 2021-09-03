class User {
  final String email;
  final String username;
  final int role;
  final String password;

  User(this.email, this.username, this.role, [this.password]);

  factory User.fromJson(Map<String, dynamic> json) {
    return User(json['Email'], json['UserName'], json['Role']);
  }
}
