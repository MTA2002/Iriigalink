import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:irrigalink/models/farmer_model.dart';

class FarmerService {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final CollectionReference _farmers =
      FirebaseFirestore.instance.collection('farmers');

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
              .pushNamed('/login', arguments: true)
              .then((value) => ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Error happened!!"),
                    ),
                  ));
        },
        codeSent: (String id, int? resendToken) {
          Navigator.of(context)
              .pushReplacementNamed('/otp_verification', arguments: [true, id]);
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

  static Future<bool> checkIfFarmerExists(String phoneNumber) async {
    QuerySnapshot<Object?> farmerQuery =
        await _farmers.where("phone_number", isEqualTo: phoneNumber).get();
    return farmerQuery.docs.isNotEmpty;
  }

  static Future<bool> saveFarmer(Farmer farmer) async {
    try {
      bool farmerExists = await checkIfFarmerExists(farmer.phoneNumber);
      if (!farmerExists) {
        String profileUrl = await storeFile(farmer.profilePicture);
        String farmUrl = await storeFile(farmer.farmImage);
        await _farmers.add({
          'full_name': farmer.name,
          'profile_pic': profileUrl,
          'phone_number': farmer.phoneNumber,
          'address': farmer.location,
          'land_size': farmer.landSize,
          'crops_produced': farmer.cropsProduced,
          'expereince': farmer.experience,
          'farm_pic': farmUrl,
          "status": 'Online',
          "isFarmConfigured": false
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

  static Future<bool> updateFarmer(Farmer farmer) async {
    try {
      QuerySnapshot<Object?> farmerQuery = await _farmers
          .where("phone_number", isEqualTo: _auth.currentUser!.phoneNumber)
          .get();
      if (farmerQuery.docs.isNotEmpty) {
        var farmerId = farmerQuery.docs.first.id;
        String profileUrl = await storeFile(farmer.profilePicture);
        String farmUrl = await storeFile(farmer.farmImage);
        Map<String, dynamic> userData = {
          'full_name': farmer.name,
          'profile_pic': profileUrl,
          'address': farmer.location,
          'land_size': farmer.landSize,
          'crops_produced': farmer.cropsProduced,
          'expereince': farmer.experience,
          'farm_pic': farmUrl,
          "status": 'Online',
        };
        await _farmers.doc(farmerId).update(userData);
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

  static Future<bool> logoutFarmer() async {
    try {
      await _auth.signOut();
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<Farmer?> getFarmer() async {
    try {
      QuerySnapshot<Object?> farmerQuery = await _farmers
          .where("phone_number", isEqualTo: _auth.currentUser!.phoneNumber)
          .get();

      if (farmerQuery.docs.isNotEmpty) {
        var farmerData = farmerQuery.docs.first.data() as Map<String, dynamic>;

        var farmer = Farmer(
          landSize: farmerData['land_size'] ?? 0,
          name: farmerData['full_name'] ?? '',
          experience: farmerData['experience'] ?? 0,
          status: farmerData['status'] ?? '',
          location: farmerData['address'] ?? '',
          phoneNumber: farmerData['phone_number'] ?? '',
          cropsProduced: farmerData['crops_produced'],
          isFarmConfigured: farmerData['isFarmConfigured'] ?? false,
          profilePicture: farmerData['profile_pic'] ?? '',
          farmImage: farmerData['farm_pic'] ?? '',
        );
        return farmer;
      } else {
        return null; // Farmer not found
      }
    } catch (e) {
      debugPrint(e.toString());
      return null; // Error occurred
    }
  }

  static Stream<Farmer> getFarmerStream() {
    return _farmers
        .where("phone_number", isEqualTo: _auth.currentUser!.phoneNumber)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => Farmer.fromMap(doc.data() as Map<String, dynamic>))
          .toList()
          .first;
    });
  }

  static Stream<List<Farmer>> getFarmersStream() {
    return _farmers.snapshots().map((snapshot) {
      return snapshot.docs
          .map((doc) => Farmer.fromMap(doc.data() as Map<String, dynamic>))
          .toList();
    });
  }

  static Future<List<Farmer>> getFarmersByIds(List<String> ids) async {
    try {
      List<Farmer> farmers = [];

      for (String farmerId in ids) {
        QuerySnapshot<Object?> farmerQuery =
            await _farmers.where("phone_number", isEqualTo: farmerId).get();

        if (farmerQuery.docs.isNotEmpty) {
          Farmer farmer = Farmer.fromMap(
              farmerQuery.docs.first.data() as Map<String, dynamic>);
          farmers.add(farmer);
        }
      }

      return farmers;
    } catch (e) {
      print("Error getting farmers by IDs: $e");
      return [];
    }
  }
}
