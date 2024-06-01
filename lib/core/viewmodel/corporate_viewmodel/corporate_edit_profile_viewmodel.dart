import 'dart:io';
import 'package:flutter/material.dart';
import 'package:pat_e/core/models/corporate_model.dart';
import 'package:pat_e/core/services/authentication/auth_service_corporate.dart';

class CorporateEditProfileViewModel with ChangeNotifier {
  final AuthServiceCorporate _authServiceCorporate = AuthServiceCorporate();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController districtController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  File? profilePhoto;

  Future<void> updateSignUp(BuildContext context, Corporate corporate) async {
    String newName = nameController.text;
    String newEmail = emailController.text;
    String newPhoneNumber = phoneNumberController.text;
    String newPassword = passwordController.text;
    String newCity = cityController.text;
    String newDistrict = districtController.text;
    String newAddress = addressController.text;

    Corporate updatedCorporate = Corporate(
      userID: corporate.userID,
      name: newName,
      email: newEmail,
      phoneNumber: newPhoneNumber,
      password: newPassword,
      city: newCity,
      district: newDistrict,
      address: newAddress,
      profilePhoto: corporate.profilePhoto,
    );

    await _authServiceCorporate
        .updateUserInformation(
      newName: newName,
      newEmail: newEmail,
      newPhoneNumber: newPhoneNumber,
      newPassword: newPassword,
      newCity: newCity,
      newDistrict: newDistrict,
      newAddress: newAddress,
      profilePhoto: profilePhoto,
    )
        .then((_) {
      // Kullanıcının güncellenmiş profilini Profile sayfasında göstermek için geri dön
      Navigator.pop(context, updatedCorporate);
    }).catchError((error) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Hata'),
            content: Text('Profil güncellenirken bir hata oluştu. $error'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Tamam'),
              ),
            ],
          );
        },
      );
    });
  }
}
