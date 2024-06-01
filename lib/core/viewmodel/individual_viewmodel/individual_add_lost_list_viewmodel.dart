// ignore_for_file: use_build_context_synchronously, unnecessary_null_comparison, avoid_print
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:pat_e/common/constants/text_strings.dart';
import 'package:pat_e/core/models/lost_animal_model.dart';
import 'package:pat_e/core/services/lost_animal_service.dart';
import 'package:pat_e/ui/views/individualUser/lost-and-found/sub_home/make_a_lost_claim.dart';

class IndividualAddLostListViewModel with ChangeNotifier {
  final LostAnimalService _lostAnimalService = LostAnimalService();

  final TextEditingController typeController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController districtController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  List<File> selectedImages = [];
  String gender = '';
  bool isLost = false;
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

  Future<void> createLostListing(BuildContext context) async {
    if (selectedImages.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Lütfen en az bir fotoğraf seçiniz')),
      );
      return;
    }

    if (selectedDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Lütfen bir tarih seçiniz')),
      );
      return;
    }

    String newLostID = DateTime.now().millisecondsSinceEpoch.toString();
    String type = typeController.text;
    String name = nameController.text;
    String age = ageController.text;
    //String gender = gender;
    String phoneNumber = phoneNumberController.text;
    String city = cityController.text;
    String district = districtController.text;
    String address = addressController.text;
    String description = descriptionController.text;

    LostAnimal lostAnimal = LostAnimal(
      lostAnimalID: newLostID,
      type: type,
      name: name,
      age: age,
      gender: gender,
      contactNumber: phoneNumber,
      city: city,
      district: district,
      address: address,
      photos: [], // Boş liste olarak başlatılsın
      description: description,
      isLost: isLost,
      lostDate: selectedDate!,
    );

    try {
      await _lostAnimalService.createLostAnimal(
          lostAnimal,
          selectedImages,
          TTexts
              .individualUsers); // Güncellenmiş nesneyi Firestore veritabanına kaydedin
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Kayıp ilanı oluşturma başarılı')),
      );
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const MakeALostClaim()),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Kayıp ilanı oluşturma başarısız')),
      );
      print(e.toString());
    }
  }
}
