// ignore_for_file: avoid_print

import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pat_e/common/constants/image_paths.dart';
import 'package:pat_e/core/models/corporate_model.dart';
import 'package:pat_e/core/services/authentication/auth_service_corporate.dart';
import 'package:pat_e/core/services/corporate_service.dart';
import 'package:pat_e/core/utils/routing/route_constant.dart';
import 'package:photo_view/photo_view.dart';

class CorporateProfileViewModel {
  final AuthServiceCorporate authService = AuthServiceCorporate();
  final CorporateService corporateService = CorporateService();
  late Corporate corporate;

  late StreamController<bool> _updateController;

  CorporateProfileViewModel() {
    _updateController = StreamController<bool>.broadcast();
  }

  // Veri güncellendiğinde stream'e haber veren metod
  Stream<bool> get updateStream => _updateController.stream;

  void notifyUIUpdate() {
    if (!_updateController.isClosed) {
      _updateController.add(true);
    }
  }

  // Diğer metodlar

  // dispose metoduyla StreamController'ı temizle
  void dispose() {
    _updateController.close();
  }

  String? profilePhotoUrl;
  String? name;
  String? surname;
  String? email;
  String? phoneNumber;
  String? city;
  String? district;
  String? address;
  bool isImageFullScreen = false;

  Future<void> getUserInfo() async {
    Corporate? fetchedCorporate = await corporateService.getUser();

    if (fetchedCorporate != null) {
      corporate = fetchedCorporate;

      profilePhotoUrl = corporate.profilePhoto;
      name = corporate.name;
      city = corporate.city;
      district = corporate.district;
      address = corporate.address;
      email = corporate.email;
      phoneNumber = corporate.phoneNumber;

      notifyUIUpdate();
    } else {
      // Eğer kullanıcı bilgileri null ise, bu durumu işleyin (örneğin bir hata mesajı gösterin)
      print('Kullanıcı bilgileri alınamadı.');
    }
  }

  Future<void> updateProfilePhoto(BuildContext context) async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      Corporate updatedCorporate = Corporate(
          userID: corporate.userID,
          name: corporate.name,
          email: corporate.email,
          password: corporate.password,
          profilePhoto: corporate.profilePhoto,
          phoneNumber: corporate.phoneNumber,
          city: corporate.city,
          district: corporate.district,
          address: corporate.address);

      await corporateService
          .updateUser(updatedCorporate, File(image.path))
          .then((_) {
        profilePhotoUrl = updatedCorporate.profilePhoto;
        notifyUIUpdate();
      }).catchError((error) {
        // Hata durumuyla ilgili işlemler
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Hata'),
              content: const Text(
                  'Profil fotoğrafı değiştirilirken bir hata oluştu.'),
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

  Future<void> showDeleteConfirmationDialog(BuildContext context) async {
    // Dialog gösterme işlemleri
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Hesap Silme Onayı'),
          content: const Text(
              'Hesabınızı silmek istediğinizden emin misiniz? Bu işlem geri alınamaz.'),
          actions: <Widget>[
            TextButton(
              child: const Text('Hayır'),
              onPressed: () {
                Navigator.of(context).pop(); // Dialog'ı kapat
              },
            ),
            TextButton(
              child: const Text('Evet'),
              onPressed: () async {
                Navigator.pushNamed(
                    context, RouteConstant.tabbarCorporateAuthRoute);
                await deleteAccount();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> deleteAccount() async {
    await authService.deleteUser();
  }

  Future<void> signOutAccount(BuildContext context) async {
    try {
      await authService.signOutUser(); // Çıkış yapma işlemi
      // ignore: use_build_context_synchronously
      Navigator.pushNamed(context, RouteConstant.onBoardScreenRoute);
      Fluttertoast.showToast(
          msg: "Çıkış yapıldı", toastLength: Toast.LENGTH_LONG);
    } catch (e) {
      Fluttertoast.showToast(
          msg: "Çıkış yapılamadı: $e", toastLength: Toast.LENGTH_LONG);
    }
  }

  void updateUserInfo(Corporate updatedCorporate) {
    corporate = updatedCorporate;
    profilePhotoUrl = updatedCorporate.profilePhoto;
    name = updatedCorporate.name;
    city = updatedCorporate.city;
    district = updatedCorporate.district;
    address = updatedCorporate.address;
    email = updatedCorporate.email;

    notifyUIUpdate();
  }

  void showFullScreenImage(BuildContext context) {
    // Tam ekran resim gösterme işlemleri
    isImageFullScreen = true;
    notifyUIUpdate();

    showDialog(
      context: context,
      builder: (_) => Container(
        padding: const EdgeInsets.all(10),
        child: GestureDetector(
          onTap: () {
            isImageFullScreen = false;
            notifyUIUpdate();
            Navigator.of(context).pop(); // Dialog'ı kapat
          },
          child: PhotoView(
            imageProvider: profilePhotoUrl != null
                ? NetworkImage(profilePhotoUrl!)
                : const AssetImage(ImagePaths.userMan)
                    as ImageProvider<Object>?,
            backgroundDecoration: const BoxDecoration(
              color: Colors.transparent,
            ),
            minScale: PhotoViewComputedScale.contained * 0.8,
            maxScale: PhotoViewComputedScale.covered * 2,
          ),
        ),
      ),
    );
  }
}
