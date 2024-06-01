// ignore_for_file: avoid_print

import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pat_e/common/helpers/custom_error_message.dart';
import 'package:pat_e/core/models/individual_model.dart';
import 'package:pat_e/core/services/authentication/authentication_service.dart';
import 'package:pat_e/core/services/individual_service.dart';

class AuthServiceIndividual extends AuthenticationService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final IndividualService _individualService = IndividualService();

  // Kiracının uygulamaya kaydolmasını sağlar
  @override
  Future<String?> signUpUser(
      {required String name,
      required String email,
      required String phoneNumber,
      required String password,
      String? city,
      String? district,
      String? address,
      File? profilePhoto}) async {
    try {
      // email, username ve password değerlerini boş olup olmadıklarını kontrol et
      if (profilePhoto == null) {
        Fluttertoast.showToast(
            msg: "Lütfen bir fotoğraf yükleyiniz!",
            toastLength: Toast.LENGTH_LONG);
        return null;
      }

      if (name.isEmpty) {
        Fluttertoast.showToast(
            msg: "Lütfen adınızı soyadınızı giriniz!",
            toastLength: Toast.LENGTH_LONG);
        return null;
      }

      if (email.isEmpty) {
        Fluttertoast.showToast(
            msg: "Lütfen e-mail adresinizi giriniz!",
            toastLength: Toast.LENGTH_LONG);
        return null;
      }

      if (phoneNumber.isEmpty) {
        Fluttertoast.showToast(
            msg: "Lütfen telefon numaranızı giriniz!",
            toastLength: Toast.LENGTH_LONG);
        return null;
      }

      if (password.isEmpty) {
        Fluttertoast.showToast(
            msg: "Lütfen şifrenizi giriniz!", toastLength: Toast.LENGTH_LONG);
        return null;
      }

      if (city!.isEmpty) {
        Fluttertoast.showToast(
            msg: "Lütfen şehrinizi giriniz!", toastLength: Toast.LENGTH_LONG);
        return null;
      }

      if (district!.isEmpty) {
        Fluttertoast.showToast(
            msg: "Lütfen ilçenizi giriniz!", toastLength: Toast.LENGTH_LONG);
        return null;
      }

      if (address!.isEmpty) {
        Fluttertoast.showToast(
            msg: "Lütfen adresinizi giriniz!", toastLength: Toast.LENGTH_LONG);
        return null;
      }

      // Bireysel kullanıcıyı Firebase Auth ile kaydet
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Oluşturulan Bireysel kullanıcıyı veritabanına kaydet
      Individual individual = Individual(
        //individualID: userCredential.user!.uid,
        userID: userCredential.user!.uid,
        name: name,
        email: email,
        phoneNumber: phoneNumber,
        password: password,
        city: city,
        district: district,
        address: address,
      );
      await _individualService.createUser(individual, profilePhoto);

      // Başarılı mesajı göster
      Fluttertoast.showToast(
        msg: "Kayıt işlemi başarılı",
      );

      return userCredential.user!.uid;
    } on FirebaseAuthException catch (e) {
      // Hata mesajını CustomErrorMessage sınıfından al
      String errorMessage = CustomErrorMessage.getRegisterErrorMessage(e.code);
      Fluttertoast.showToast(
          msg: "Uyarı: $errorMessage", toastLength: Toast.LENGTH_LONG);
    }
    return null;
  }

  // Bireysel kullanıcının uygulamaya giriş yapmasını sağlar
  @override
  Future<String?> signInUser(
      {required String email, required String password}) async {
    try {
      if (email.isEmpty) {
        Fluttertoast.showToast(
            msg: "Lütfen email adresinizi giriniz!",
            toastLength: Toast.LENGTH_LONG);
        return null;
      }

      if (password.isEmpty) {
        Fluttertoast.showToast(
            msg: "Lütfen şifrenizi giriniz!", toastLength: Toast.LENGTH_LONG);
        return null;
      }

      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      Fluttertoast.showToast(
        msg: "Giriş işlemi başarılı",
        toastLength: Toast.LENGTH_SHORT,
      );

      return userCredential.user!.uid;
    } on FirebaseAuthException catch (e) {
      String errorMessage = CustomErrorMessage.getLoginErrorMessage(e.code);
      Fluttertoast.showToast(
          msg: "Uyarı: $errorMessage", toastLength: Toast.LENGTH_LONG);
    }
    return null;
  }

  // Bireysel kullanıcının uygulamadan çıkış yapmasını sağlar
  @override
  Future<void> signOutUser() async {
    try {
      await _auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }

  // Bireysel kullanıcının şifresini sıfırlama isteği gönderir
  @override
  Future<void> resetPasswordUser(BuildContext context, String email) async {
    final navigator = Navigator.of(context);
    try {
      if (email.isEmpty) {
        Fluttertoast.showToast(
            msg: "Lütfen e-posta adresinizi giriniz!",
            toastLength: Toast.LENGTH_LONG);
        return;
      }
      await _auth.sendPasswordResetEmail(email: email);
      Fluttertoast.showToast(
        msg: "E-posta adresinize bir şifre sıfırlama isteği gönderildi",
        toastLength: Toast.LENGTH_LONG,
      );
      navigator.pop();
    } on FirebaseAuthException catch (e) {
      String errorMessage =
          CustomErrorMessage.getForgotPasswordErrorMessage(e.code);
      Fluttertoast.showToast(
          msg: "Uyarı: $errorMessage", toastLength: Toast.LENGTH_LONG);
    }
  }

  @override
  Future<void> deleteUser() async {
    try {
      String uid = _auth.currentUser!.uid;

      // Firebase Authentication'dan Bireysel kullanıcıyı sil
      await _auth.currentUser!.delete();

      // Bireysel kullanıcıyı Firestore'dan sil
      await _individualService.deleteUser(uid);

      // Başarılı mesajı göster
      Fluttertoast.showToast(
        msg: "Bireysel Kullanıcı hesabı başarıyla silindi.",
        toastLength: Toast.LENGTH_LONG,
      );

      // Çıkış yap ve profil sayfasından yönlendir
      await signOutUser();
    } catch (e) {
      print("HATA: ${e.toString()}");
      // Hata mesajını göster
      Fluttertoast.showToast(
        msg: "Bireysel Kullanıcı hesabını silerken bir hata oluştu.",
        toastLength: Toast.LENGTH_LONG,
      );

      return;
    }
  }

  @override
  Future<void> updateUserInformation(
      {required String newName,
      required String newEmail,
      required String newPhoneNumber,
      required String newPassword,
      String? newCity,
      String? newDistrict,
      String? newAddress,
      File? profilePhoto}) async {
    try {
      User? currentUser = _auth.currentUser;

      if (currentUser != null) {
        // Bireysel kullanıcının Firebase Authentication e-postasını güncelle
        if (newEmail != currentUser.email) {
          await currentUser.verifyBeforeUpdateEmail(
              newEmail); //Eski fonksiyon: updateEmail()
        }

        // Bireysel kullanıcının Firebase Authentication şifresini güncelle
        await currentUser.updatePassword(newPassword);
        //await currentUser.updatePhoneNumber(newPhoneNumber as PhoneAuthCredential);
        //await currentUser.updatePhotoURL(profilePhoto.toString());

        // Firestore'dan Bireysel kullanıcının mevcut bilgilerini al
        Individual? individual = await _individualService.getUser();

        if (individual != null) {
          // Bireysel kullanıcının Firestore Database bilgilerini güncelle
          individual.name = newName;
          individual.email = newEmail;
          individual.phoneNumber = newPhoneNumber;
          individual.password = newPassword;
          individual.city = newCity ?? individual.city;
          individual.district = newDistrict ?? individual.district;
          individual.address = newAddress ?? individual.address;

          await _individualService.updateUser(individual);
        }
      }
    } on FirebaseAuthException catch (e) {
      String errorMessage =
          CustomErrorMessage.getUpdateUserErrorMessage(e.code);
      Fluttertoast.showToast(
          msg: "Uyarı: $errorMessage, $e", toastLength: Toast.LENGTH_LONG);
    }
  }
}
