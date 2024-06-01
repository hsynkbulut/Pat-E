// ignore_for_file: use_build_context_synchronously, unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:pat_e/core/services/authentication/auth_service_corporate.dart';
import 'package:pat_e/core/utils/routing/route_constant.dart';

class LoginViewModelCorporate with ChangeNotifier {
  final AuthServiceCorporate _authServiceCorporate = AuthServiceCorporate();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> signIn(BuildContext context) async {
    String? email = emailController.text;
    String? password = passwordController.text;

    if (email != null && password != null) {
      String? corporateID = await _authServiceCorporate.signInUser(
          email: email, password: password);

      if (corporateID != null) {
        // Giriş başarılı, yapılacak işlemler
        // Örneğin: Ana sayfaya yönlendirme
        Navigator.pushNamed(context, RouteConstant.corporateDashboardRoute);
      } else {
        // Giriş başarısız, hata işlemleri
        // Örneğin: Hatalı giriş bilgileri mesajı gösterme
      }
    }
  }
}
