import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:irrigalink/models/distributor_model.dart';

class DistributorService {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final CollectionReference _distributors =
      FirebaseFirestore.instance.collection('distributors');

  static Future<void> sendOtp(
      String phoneNumber, BuildContext context, bool isFarmer) async {
    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await _auth.signInWithCredential(credential).then(
                (value) => debugPrint('Logged In Successfully'),
              );
        },
        verificationFailed: (FirebaseAuthException e) {
          debugPrint(e.message);
          Navigator.of(context)
              .pushNamed('/login', arguments: isFarmer)
              .then((value) => ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Error happened!!"),
                    ),
                  ));
        },
        codeSent: (String id, int? resendToken) {
          Navigator.of(context).pushReplacementNamed('/otp_verification',
              arguments: [isFarmer, id]);
          debugPrint("verificationid$id");
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
    } catch (e) {
      Navigator.of(context)
          .pushNamed('/login', arguments: true)
          .then((value) => ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Error2 happened!!"),
                ),
              ));
    }
  }

  static Future<bool> verifyPhoneNumber({
    required String verificationId,
    required String otp,
  }) async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: otp,
      );
      await _auth.signInWithCredential(credential);
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<bool> checkIfDistExists(String phoneNumber) async {
    QuerySnapshot<Object?> distQuery = await _distributors
        .where("phone_number", isEqualTo: "+251989234566")
        .get();
    print("DQ${distQuery.docs}");
    return distQuery.docs.isNotEmpty;
  }

  static Future<bool> saveDistributor(Distributor distributor) async {
    try {
      bool distExists = await checkIfDistExists(distributor.phoneNumber);
      if (!distExists) {
        String profileUrl = await storeFile(distributor.profilePicture);
        String storeUrl = await storeFile(distributor.storeImage);
        await _distributors.add({
          'full_name': distributor.name,
          'profile_pic': profileUrl,
          'phone_number': distributor.phoneNumber,
          'address': distributor.location,
          'crops_selled': distributor.cropsSelled,
          'expereince': distributor.experience,
          'store_pic': storeUrl,
          "status": 'Online',
        });
        return true;
      } else {
        return false;
      }
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  static Future<bool> updateDistributor(Distributor distributor) async {
    try {
      QuerySnapshot<Object?> distQuery = await _distributors
          .where("phone_number", isEqualTo: _auth.currentUser!.phoneNumber)
          .get();
      if (distQuery.docs.isNotEmpty) {
        var distId = distQuery.docs.first.id;
        String profileUrl = await storeFile(distributor.profilePicture);
        String farmUrl = await storeFile(distributor.storeImage);
        Map<String, dynamic> userData = {
          'full_name': distributor.name,
          'profile_pic': profileUrl,
          'address': distributor.location,
          'crops_selled': distributor.cropsSelled,
          'expereince': distributor.experience,
          'store_pic': farmUrl,
          "status": 'Online',
        };
        await _distributors.doc(distId).update(userData);
        return true;
      } else {
        return false;
      }
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  static Future<String> storeFile(File file) async {
    var storage = FirebaseStorage.instance;
    try {
      var randName = getRandString(15);
      TaskSnapshot taskSnapshot =
          await storage.ref('images/$randName.jpg').putFile(file);
      final String downloadUrl = await taskSnapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      debugPrint(e.toString());
      return "Not able to upload file";
    }
  }

  static String getRandString(int len) {
    var random = Random.secure();
    var values = List.generate(len, (i) => random.nextInt(255));
    return base64UrlEncode(values);
  }

  static Future<bool> logoutDistributor() async {
    try {
      await _auth.signOut();
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<Distributor?> getDistributor() async {
    try {
      QuerySnapshot<Object?> distQuery = await _distributors
          .where("phone_number", isEqualTo: _auth.currentUser!.phoneNumber)
          .get();

      if (distQuery.docs.isNotEmpty) {
        var distData = distQuery.docs.first.data() as Map<String, dynamic>;

        var distributor = Distributor(
          name: distData['full_name'] ?? '',
          experience: distData['expereince'] ?? 0,
          status: distData['status'] ?? '',
          location: distData['address'] ?? '',
          phoneNumber: distData['phone_number'] ?? '',
          cropsSelled: distData['crops_selled'],
          profilePicture: distData['profile_pic'] ?? '',
          storeImage: distData['store_pic'] ?? '',
          id: '',
        );
        return distributor;
      } else {
        return null;
      }
    } catch (e) {
      debugPrint(e.toString());
      return null; // Error occurred
    }
  }

  static Stream<Distributor> getDistStream() {
    return _distributors
        .where("phone_number", isEqualTo: _auth.currentUser!.phoneNumber)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => Distributor.fromMap(doc.data() as Map<String, dynamic>))
          .toList()
          .first;
    });
  }

  static Stream<List<Distributor>> getDistributorStream() {
    return _distributors.snapshots().map((snapshot) {
      return snapshot.docs
          .map((doc) => Distributor.fromMap(doc.data() as Map<String, dynamic>))
          .toList();
    });
  }

  static Future<List<Distributor>> getDistributorsByIds(
      List<String> ids) async {
    try {
      List<Distributor> distributors = [];

      for (String distributorsId in ids) {
        QuerySnapshot<Object?> distQuery = await _distributors
            .where("phone_number", isEqualTo: distributorsId)
            .get();

        if (distQuery.docs.isNotEmpty) {
          Distributor farmer = Distributor.fromMap(
              distQuery.docs.first.data() as Map<String, dynamic>);
          distributors.add(farmer);
        }
      }

      return distributors;
    } catch (e) {
      print("Error getting farmers by IDs: $e");
      return [];
    }
  }
}
