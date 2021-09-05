class User {
  int userId;
  final String email;
  final String username;
  final int role;
  final String password;

  User(this.email, this.username, this.role, this.password, [this.userId]);

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      json['Email'],
      json['UserName'],
      json['Role'],
      json['Password'],
      json['UserId'],
    );
  }
}
