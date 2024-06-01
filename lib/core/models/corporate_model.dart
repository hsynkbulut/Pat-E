import 'package:pat_e/core/models/users_model.dart';

// Kurumsal Kullanıcı sınıfı (Corporate)
class Corporate extends Users {
  Corporate({
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

  // Corporate sınıfını Map'e dönüştürme
  @override
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = super.toMap();
    return map;
  }

  // Map'i Corporate sınıfına dönüştürme
  Corporate.fromMap(Map<String, dynamic> map)
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
