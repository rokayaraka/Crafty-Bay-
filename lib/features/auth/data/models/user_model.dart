class UserModel {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String city;

  UserModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.city,
  });

factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? '',
      firstName: json['first_name'] ?? '',
      lastName: json['last_name'] ?? '',
      email: json['email'] ?? '',
      city: json['city'] ?? '',
    );
  }
}