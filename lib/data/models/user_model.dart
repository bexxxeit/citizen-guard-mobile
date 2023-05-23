// ignore_for_file: public_member_api_docs, sort_constructors_first
class RegistrationUserModel {
  String iin;
  String password;
  String firstName;
  String lastName;
  String middleName;
  String phoneNumber;
  String cityName;
  String address;
  RegistrationUserModel({
    required this.iin,
    required this.password,
    required this.firstName,
    required this.lastName,
    required this.middleName,
    required this.phoneNumber,
    required this.cityName,
    required this.address,
  });

  @override
  String toString() {
    return 'UserModel(iin: $iin, password: $password, firstName: $firstName, lastName: $lastName, middleName: $middleName, phoneNumber: $phoneNumber, cityName: $cityName, address: $address)';
  }
}
