class AnimalAdoption {
  String? animalID;
  String type;
  String name;
  String age;
  String gender;
  List<String>?
      photos; //kullanıcının oluşturacağı ilanda yükleyeceği hayvanların fotoğraflarını liste şeklinde tutacak.
  String adoptionConditions;
  String contactNumber;
  String city;
  String district;
  String address;
  bool isAdopted;

  AnimalAdoption(
      {this.animalID,
      required this.type,
      required this.name,
      required this.age,
      required this.gender,
      required this.photos,
      required this.adoptionConditions,
      required this.contactNumber,
      required this.city,
      required this.district,
      required this.address,
      required this.isAdopted});

  // AnimalAdoption sınıfını Map'e dönüştürme
  Map<String, dynamic> toMap() {
    return {
      'animalID': animalID,
      'type': type,
      'name': name,
      'age': age,
      'gender': gender,
      'photos': photos,
      'adoptionConditions': adoptionConditions,
      'contactNumber': contactNumber,
      'city': city,
      'district': district,
      'address': address,
      'isAdopted': isAdopted
    };
  }

  // Map'i AnimalAdoption sınıfına dönüştürme
  AnimalAdoption.fromMap(Map<String, dynamic> map)
      : animalID = map['animalID'],
        type = map['type'],
        name = map['name'],
        age = map['age'],
        gender = map['gender'],
        photos = List<String>.from(map['photos']),
        adoptionConditions = map['adoptionConditions'],
        contactNumber = map['contactNumber'],
        city = map['city'],
        district = map['district'],
        address = map['address'],
        isAdopted = map['isAdopted'];
}
