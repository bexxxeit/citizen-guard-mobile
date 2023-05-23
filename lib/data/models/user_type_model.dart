// ignore_for_file: public_member_api_docs, sort_constructors_first
class UserModel {
  String name;
  String city;
  String role;
  String username;
  UserModel({
    required this.name,
    required this.city,
    required this.role,
    required this.username,
  });

  @override
  String toString() {
    return 'UserType(name: $name, city: $city, role: $role, username: $username)';
  }
}
