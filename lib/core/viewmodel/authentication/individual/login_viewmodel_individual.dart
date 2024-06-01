// ignore_for_file: use_build_context_synchronously, unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:pat_e/core/services/authentication/auth_service_individual.dart';
import 'package:pat_e/core/utils/routing/route_constant.dart';

class LoginViewModelIndividual with ChangeNotifier {
  final AuthServiceIndividual _authServiceIndividual = AuthServiceIndividual();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> signIn(BuildContext context) async {
    String? email = emailController.text;
    String? password = passwordController.text;

    if (email != null && password != null) {
      String? individualID = await _authServiceIndividual.signInUser(
          email: email, password: password);

      if (individualID != null) {
        Navigator.pushNamed(context, RouteConstant.individualBottomNavbarRoute);
      } else {
        // Giriş başarısız, hata işlemleri
      }
    }
  }
}
