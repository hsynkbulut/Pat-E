import 'package:pat_e/core/models/users_model.dart';

// Bireysel Kullanıcı sınıfı (Individual)
class Individual extends Users {
  Individual({
    super.userID,
    required super.name,
    required super.email,
    required super.phoneNumber,
    required super.password,
    required super.city,
    required super.district,
    required super.address,
    super.profilePhoto,
  }) : super();

  // Individual sınıfını Map'e dönüştürme
  @override
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = super.toMap();
    return map;
  }

  // Map'i Individual sınıfına dönüştürme
  Individual.fromMap(Map<String, dynamic> map)
      : super(
          userID: map['userID'],
          name: map['name'],
          email: map['email'],
          phoneNumber: map['phoneNumber'],
          password: map['password'],
          city: map['city'],
          district: map['district'],
          address: map['address'],
          profilePhoto: map['profilePhoto'],
        );
}
