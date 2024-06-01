// ignore_for_file: avoid_print

import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pat_e/common/helpers/custom_error_message.dart';
import 'package:pat_e/core/models/corporate_model.dart';
import 'package:pat_e/core/services/authentication/authentication_service.dart';
import 'package:pat_e/core/services/corporate_service.dart';

class AuthServiceCorporate extends AuthenticationService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final CorporateService _homeOwnerService = CorporateService();
  //final HouseListingService _houseListingService = HouseListingService();

  // Ev sahibinin uygulamaya kaydolmasını sağlar
  @override
  Future<String?> signUpUser({
    required String name,
    required String email,
    required String phoneNumber,
    required String password,
    File? profilePhoto,
    String? city,
    String? district,
    String? address,
  }) async {
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
            msg: "Lütfen kurum adınızı giriniz!",
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

      // Kurumsal Kullanıcıyı Firebase Auth ile kaydet
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Oluşturulan Kurumsal Kullanıcıyı veritabanına kaydet
      Corporate homeOwner = Corporate(
          userID: userCredential.user!.uid,
          name: name,
          email: email,
          phoneNumber: phoneNumber,
          password: password,
          city: city,
          district: district,
          address: address);
      await _homeOwnerService.createUser(homeOwner, profilePhoto);

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
      print("Uyarı mesajı: $e");
    }
    return null;
  }

  // Kurumsal Kullanıcının uygulamaya giriş yapmasını sağlar
  @override
  Future<String?> signInUser({
    required String email,
    required String password,
  }) async {
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

  // Kurumsal Kullanıcının uygulamadan çıkış yapmasını sağlar
  @override
  Future<void> signOutUser() async {
    try {
      await _auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }

  // Kurumsal Kullanıcının şifresini sıfırlama isteği gönderir
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

      // Kurumsal Kullanıcının ilanlarını sil
      //await _houseListingService.deleteHouseListingsOfUser(uid);

      // Firebase Authentication'dan kullanıcıyı sil
      await _auth.currentUser!.delete();

      // Kurumsal Kullanıcıyı Firestore'dan sil
      await _homeOwnerService.deleteUser(uid);

      // Başarılı mesajı göster
      Fluttertoast.showToast(
        msg: "Kurumsal Kullanıcı hesabı başarıyla silindi.",
        toastLength: Toast.LENGTH_LONG,
      );

      // Çıkış yap ve profil sayfasından yönlendir
      await signOutUser();
    } catch (e) {
      print("HATA: ${e.toString()}");
      // Hata mesajını göster
      Fluttertoast.showToast(
        msg: "Kurumsal Kullanıcı hesabını silerken bir hata oluştu.",
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
        // Kurumsal kullanıcının Firebase Authentication e-postasını güncelle
        if (newEmail != currentUser.email) {
          await currentUser.verifyBeforeUpdateEmail(
              newEmail); //Eski fonksiyon: updateEmail()
        }

        // Kurumsal kullanıcının Firebase Authentication şifresini güncelle
        await currentUser.updatePassword(newPassword);
        //await currentUser.updatePhoneNumber(newPhoneNumber as PhoneAuthCredential);
        //await currentUser.updatePhotoURL(profilePhoto.toString());

        // Firestore'dan Kurumsal Kullanıcının mevcut bilgilerini al
        Corporate? homeOwner = await _homeOwnerService.getUser();

        if (homeOwner != null) {
          // Kurumsal Kullanıcının Firestore Database bilgilerini güncelle
          homeOwner.name = newName;
          homeOwner.email = newEmail;
          homeOwner.phoneNumber = newPhoneNumber;
          homeOwner.password = newPassword;
          homeOwner.city = newCity ?? homeOwner.city;
          homeOwner.district = newDistrict ?? homeOwner.district;
          homeOwner.address = newAddress ?? homeOwner.address;

          await _homeOwnerService.updateUser(homeOwner, profilePhoto);
        }
      }
    } on FirebaseAuthException catch (e) {
      String errorMessage =
          CustomErrorMessage.getUpdateUserErrorMessage(e.code);
      Fluttertoast.showToast(
          msg: "Uyarı: $errorMessage", toastLength: Toast.LENGTH_LONG);
    }
  }
}
