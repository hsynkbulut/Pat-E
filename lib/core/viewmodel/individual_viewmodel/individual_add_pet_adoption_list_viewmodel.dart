// ignore_for_file: use_build_context_synchronously, unnecessary_null_comparison, avoid_print
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:pat_e/common/constants/text_strings.dart';
import 'package:pat_e/core/models/animal_adoption_model.dart';
import 'package:pat_e/core/services/animal_adoption_service.dart';
import 'package:pat_e/ui/views/individualUser/animal_adoption/sub_home/rehoming_the_animal.dart';

class IndividualAddPetAdoptionListViewModel with ChangeNotifier {
  //final HouseListingService _houseListingService = HouseListingService();
  final AnimalAdoptionService _corporateAnimalAdoptionService =
      AnimalAdoptionService();

  final TextEditingController typeController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController adoptionConditionsController =
      TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController districtController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  List<File> selectedImages = [];
  String gender = '';
  bool isAdopted = false;

  final ValueNotifier<bool> attachMultipleImages = ValueNotifier<bool>(false);

  // ViewModel içinde compressedPhotosList'i güncellemek için bir metod
  void updateCompressedPhotosList(List<File> updatedList) {
    selectedImages = updatedList;
  }

  // Eğer bu liste dışarıdan alınacaksa, bu metodu kullanabilirsin:
  // void setCompressedPhotosList(List<String> updatedList) {
  //   compressedPhotos = updatedList;
  // }

  Future<void> createPetAdoptionListing(BuildContext context) async {
    if (selectedImages.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Lütfen en az bir fotoğraf seçiniz')),
      );
      return;
    }

    String newPetAdoptionID = DateTime.now().millisecondsSinceEpoch.toString();
    String type = typeController.text;
    String name = nameController.text;
    String age = ageController.text;
    //String gender = gender;
    String adoptionConditions = adoptionConditionsController.text;
    String phoneNumber = phoneNumberController.text;
    String city = cityController.text;
    String district = districtController.text;
    String address = addressController.text;

    AnimalAdoption houseListing = AnimalAdoption(
      animalID: newPetAdoptionID,
      type: type,
      name: name,
      age: age,
      gender: gender,
      adoptionConditions: adoptionConditions,
      contactNumber: phoneNumber,
      city: city,
      district: district,
      address: address,
      photos: [], // Boş liste olarak başlatılsın
      isAdopted: isAdopted,
    );

    try {
      await _corporateAnimalAdoptionService.createAnimalAdoption(
          houseListing,
          selectedImages,
          TTexts
              .individualUsers); // Güncellenmiş nesneyi Firestore veritabanına kaydedin
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Sahiplendirme ilanı oluşturma başarılı')),
      );
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const RehomingTheAnimal()),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Sahiplendirme ilanı oluşturma başarısız')),
      );
      print(e.toString());
    }
  }
}
