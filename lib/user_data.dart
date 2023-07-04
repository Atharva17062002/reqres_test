class User {
  final int id;
  final String avatar;
  final String firstName;
  final String lastName;
  final String email;

  User( {required this.id, required this.firstName, required this.lastName, required this.email,required this.avatar,});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      avatar:json['avatar'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      email: json['email'],
    );
  }
}
