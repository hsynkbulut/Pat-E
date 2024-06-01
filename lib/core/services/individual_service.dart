// ignore_for_file: avoid_print, avoid_renaming_method_parameters

import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:pat_e/core/models/individual_model.dart';
import 'package:pat_e/core/services/user_service.dart';

class IndividualService extends UserService<Individual> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  @override
  Future createUser(Individual individual, [File? profilePhoto]) async {
    try {
      String uid =
          _auth.currentUser!.uid; // Kiracı kimliğini Firebase Auth'tan al
      DocumentReference userRef = _firestore
          .collection('individualUsers')
          .doc(uid); // Belge referansını kiracı kimliği ile oluştur
      await userRef.set(individual.toMap()); // Belgeyi veritabanına kaydet

      if (profilePhoto != null) {
        String photoURL = await uploadProfilePhoto(
            uid, profilePhoto); // Profil fotoğrafını yükle
        await userRef.update({
          'profilePhoto': photoURL
        }); // Belgeyi profil fotoğrafı ile güncelle
      }
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Future updateUser(Individual individual, [File? newProfilePhoto]) async {
    try {
      String uid = _auth.currentUser!.uid;
      await _firestore
          .collection('individualUsers')
          .doc(uid)
          .update(individual.toMap());

      if (newProfilePhoto != null) {
        String photoURL = await uploadProfilePhoto(uid, newProfilePhoto);
        await _firestore
            .collection('users')
            .doc(uid)
            .update({'profilePhoto': photoURL});
      }
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Future<void> deleteUser(String userID) async {
    try {
      await _firestore.collection('individualUsers').doc(userID).delete();
      await deleteProfilePhoto(userID);
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Future<Individual?> getUser() async {
    try {
      String uid = _auth.currentUser!.uid;

      DocumentSnapshot doc =
          await _firestore.collection('individualUsers').doc(uid).get();

      if (doc.exists) {
        Individual individual =
            Individual.fromMap(doc.data() as Map<String, dynamic>);
        return individual;
      } else {
        return null;
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<String> uploadProfilePhoto(String userID, File photo) async {
    try {
      Reference ref = _storage
          .ref()
          .child('individualUsers')
          .child(userID)
          .child('profilePhoto.jpg');

      UploadTask task = ref.putFile(photo);
      await task.whenComplete(() {});

      String photoURL = await ref.getDownloadURL();
      return photoURL;
    } catch (e) {
      print(e.toString());
      throw Exception('Failed to upload profile photo.');
    }
  }

  Future<void> deleteProfilePhoto(String userID) async {
    try {
      Reference ref = _storage
          .ref()
          .child('individualUsers')
          .child(userID)
          .child('profilePhoto.jpg');
      await ref.delete();
    } catch (e) {
      print(e.toString());
    }
  }
}
