// IUsers Interface
abstract class IUsers {
  String? get userID;
  String get name;
  String get email;
  String get phoneNumber;
  String get password;
  String get city;
  String get district;
  String get address;
  String? get profilePhoto;
  Map<String, dynamic> toMap();
}

// Users Class
class Users implements IUsers {
  @override
  String? userID;
  @override
  String name;
  @override
  String email;
  @override
  String phoneNumber;
  @override
  String password;
  @override
  String city;
  @override
  String district;
  @override
  String address;
  @override
  String? profilePhoto;

  Users({
    this.userID,
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.password,
    required this.city,
    required this.district,
    required this.address,
    this.profilePhoto,
  });

  @override
  Map<String, dynamic> toMap() {
    return {
      'userID': userID,
      'name': name,
      'email': email,
      'phoneNumber': phoneNumber,
      'password': password,
      'city': city,
      'district': district,
      'address': address,
      'profilePhoto': profilePhoto,
    };
  }
}
