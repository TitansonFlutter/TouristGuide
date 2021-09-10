final String userTableName = "Users";

class UserField {
  static final List<String> values = [
    /// Add all fields
    id, userId, email, username, role
  ];

  static final String id = "_id";
  static final String userId = "userId";

  static final String email = "email";
  static final String username = "username";
  static final String role = "role";
}

class User {
  final int id;
  final int userId;
  final String email;
  final String username;
  final int role;
  final String password;

  User(this.userId, this.email, this.username, this.role,
      [this.password, this.id]);

  User copy({
    int id,
    int userId,
    String email,
    String username,
    int role,
  }) =>
      User(
        userId,
        email,
        username,
        role,
      );

  factory User.fromJson(Map<String, dynamic> json) {
    return User(json['UserId'] as int, json['Email'],
        json['UserName'] as String, json['Role'] as int);
  }

  Map<String, dynamic> toJson() {
    return {
      'UserId': userId,
      'Email': email,
      'UserName': username,
      'Role': role
    };
  }
}
