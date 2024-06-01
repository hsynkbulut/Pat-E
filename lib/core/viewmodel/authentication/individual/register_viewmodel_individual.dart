// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:pat_e/core/services/authentication/auth_service_individual.dart';
import 'package:pat_e/core/utils/routing/route_constant.dart';

class RegisterViewModelIndividual with ChangeNotifier {
  final AuthServiceIndividual _authServiceIndividual = AuthServiceIndividual();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController districtController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  File? profilePhoto;

  Future<void> signUp(BuildContext context) async {
    String? result = await _authServiceIndividual.signUpUser(
      name: nameController.text,
      email: emailController.text,
      phoneNumber: phoneNumberController.text,
      password: passwordController.text,
      profilePhoto: profilePhoto,
      city: cityController.text,
      district: districtController.text,
      address: addressController.text,
    );

    if (result != null) {
      Navigator.pushNamed(context, RouteConstant.individualBottomNavbarRoute);
    } else {
      // Kayıt başarısız, kullanıcıya bir hata mesajı gösterebilirsiniz.
    }
  }
}
