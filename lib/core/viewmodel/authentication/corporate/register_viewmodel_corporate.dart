// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:pat_e/core/services/authentication/auth_service_corporate.dart';
import 'package:pat_e/core/utils/routing/route_constant.dart';

class RegisterViewModelCorporate with ChangeNotifier {
  //final AuthServiceCorporate _authenticationService = locator<AuthServiceCorporate>();
  final AuthServiceCorporate _authServiceCorporate = AuthServiceCorporate();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController surnameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController districtController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  File? profilePhoto;

  Future<void> signUp(BuildContext context) async {
    String? result = await _authServiceCorporate.signUpUser(
      name: nameController.text,
      email: emailController.text,
      phoneNumber: phoneNumberController.text,
      password: passwordController.text,
      city: cityController.text,
      district: districtController.text,
      address: addressController.text,
      profilePhoto: profilePhoto,
    );

    if (result != null) {
      // Kayıt başarılı, işlemler devam edebilir.
      // Örneğin, ana sayfaya yönlendirme yapabilirsiniz.
      Navigator.pushNamed(context, RouteConstant.corporateDashboardRoute);
    } else {
      // Kayıt başarısız, kullanıcıya bir hata mesajı gösterebilirsiniz.
    }
  }
}
