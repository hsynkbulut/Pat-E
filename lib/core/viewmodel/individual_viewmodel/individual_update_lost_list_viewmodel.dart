// ignore_for_file: use_build_context_synchronously, unnecessary_null_comparison, avoid_print
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pat_e/common/constants/text_strings.dart';
import 'package:pat_e/core/models/lost_animal_model.dart';
import 'package:pat_e/core/services/lost_animal_service.dart';
import 'package:pat_e/ui/views/individualUser/lost-and-found/update_lost_listings/individual_update_lost_listing.dart';

class IndividualUpdateLostListViewModel with ChangeNotifier {
  final LostAnimalService _lostListingService = LostAnimalService();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController typeController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController districtController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  List<File> selectedImages = [];
  bool isLost = false;
  String gender = '';
  DateTime? selectedDate;

  final ValueNotifier<bool> attachMultipleImages = ValueNotifier<bool>(false);

  // ViewModel içinde compressedPhotosList'i güncellemek için bir metod
  void updateCompressedPhotosList(List<File> updatedList) {
    selectedImages = updatedList;
  }

  // Eğer bu liste dışarıdan alınacaksa, bu metodu kullanabilirsin:
  // void setCompressedPhotosList(List<String> updatedList) {
  //   compressedPhotos = updatedList;
  // }

  Future<void> updateLostListing(
      BuildContext context, LostAnimal lostListing) async {
    if (selectedImages.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Lütfen en az bir fotoğraf seçiniz')),
      );
      return;
    }

    String newLostID = lostListing.lostAnimalID!;
    String name = nameController.text;
    String type = typeController.text;
    String age = ageController.text;
    String city = cityController.text;
    String district = districtController.text;
    String address = addressController.text;
    String description = descriptionController.text;
    String phoneNumber = phoneNumberController.text;

    LostAnimal updateLostListing = LostAnimal(
      lostAnimalID: newLostID,
      name: name,
      type: type,
      age: age,
      city: city,
      district: district,
      address: address,
      description: description,
      contactNumber: phoneNumber,
      photos: [], // Boş liste olarak başlatılsın
      isLost: isLost,
      gender: gender,
      lostDate: selectedDate as DateTime,
    );

    try {
      // Mevcut sahiplendirme ilanının bilgilerini al
      LostAnimal? currentLostListing = await _lostListingService.getLostAnimal(
          lostListing.lostAnimalID!, TTexts.individualUsers);

      // Eski resimlerle yeni resimler arasında fark kontrolü
      List<String?> currentPhotos = currentLostListing?.photos ?? [];
      List<String?> newPhotos =
          selectedImages.map((photo) => photo.path).toList();

      bool photosChanged = currentPhotos.length != newPhotos.length ||
          !listEquals(currentPhotos, newPhotos);

      if (photosChanged) {
        // Resimler değiştiyse, eski resimleri sil
        await _lostListingService.deletePhotos(
            lostListing.lostAnimalID!, TTexts.individualUsers);
      }

      // Ev ilanını güncelleme
      await _lostListingService.updateLostAnimal(
          updateLostListing, selectedImages, TTexts.individualUsers);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Kayıp ilanı güncelleme başarılı')),
      );
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => const IndividualUpdateLostListingScreen()),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Kayıp ilanı güncelleme başarısız')),
      );
      print(e.toString());
    }
  }
}
