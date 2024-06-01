// ignore_for_file: use_build_context_synchronously, unnecessary_null_comparison, avoid_print
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pat_e/common/constants/text_strings.dart';
import 'package:pat_e/core/models/animal_adoption_model.dart';
import 'package:pat_e/core/services/animal_adoption_service.dart';
import 'package:pat_e/core/utils/routing/route_constant.dart';

class CorporateUpdatePetAdoptionListViewModel with ChangeNotifier {
  final AnimalAdoptionService _petAdoptionListingService =
      AnimalAdoptionService();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController typeController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController adoptionConditionsController =
      TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController districtController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  List<File> selectedImages = [];
  bool isAdopted = false;
  String gender = '';

  final ValueNotifier<bool> attachMultipleImages = ValueNotifier<bool>(false);

  // ViewModel içinde compressedPhotosList'i güncellemek için bir metod
  void updateCompressedPhotosList(List<File> updatedList) {
    selectedImages = updatedList;
  }

  // Eğer bu liste dışarıdan alınacaksa, bu metodu kullanabilirsin:
  // void setCompressedPhotosList(List<String> updatedList) {
  //   compressedPhotos = updatedList;
  // }

  Future<void> updateHouseListing(
      BuildContext context, AnimalAdoption petAdoptionListing) async {
    if (selectedImages.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Lütfen en az bir fotoğraf seçiniz')),
      );
      return;
    }

    String newPetAdoptionID = petAdoptionListing.animalID!;
    String name = nameController.text;
    String type = typeController.text;
    String age = ageController.text;
    String city = cityController.text;
    String district = districtController.text;
    String address = addressController.text;
    String adoptionConditions = adoptionConditionsController.text;
    String phoneNumber = phoneNumberController.text;

    AnimalAdoption updateHouseListing = AnimalAdoption(
      animalID: newPetAdoptionID,
      name: name,
      type: type,
      age: age,
      city: city,
      district: district,
      address: address,
      adoptionConditions: adoptionConditions,
      contactNumber: phoneNumber,
      photos: [], // Boş liste olarak başlatılsın
      isAdopted: isAdopted,
      gender: gender,
    );

    try {
      // Mevcut sahiplendirme ilanının bilgilerini al
      AnimalAdoption? currentPetAdoptionListing =
          await _petAdoptionListingService.getAnimalAdoption(
              petAdoptionListing.animalID!, TTexts.corporateUsers);

      // Eski resimlerle yeni resimler arasında fark kontrolü
      List<String?> currentPhotos = currentPetAdoptionListing?.photos ?? [];
      List<String?> newPhotos =
          selectedImages.map((photo) => photo.path).toList();

      bool photosChanged = currentPhotos.length != newPhotos.length ||
          !listEquals(currentPhotos, newPhotos);

      if (photosChanged) {
        // Resimler değiştiyse, eski resimleri sil
        await _petAdoptionListingService.deletePhotos(
            petAdoptionListing.animalID!, TTexts.corporateUsers);
      }

      // Ev ilanını güncelleme
      await _petAdoptionListingService.updateAnimalAdoption(
          updateHouseListing, selectedImages, TTexts.corporateUsers);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Sahiplendirme ilanı güncelleme başarılı')),
      );
      Navigator.pushNamed(context, RouteConstant.corporateDashboardRoute);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Sahiplendirme ilanı güncelleme başarısız')),
      );
      print(e.toString());
    }
  }
}
