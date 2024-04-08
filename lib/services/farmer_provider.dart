import 'package:flutter/material.dart';
import 'package:irrigalink/models/farmer_model.dart';
import 'package:irrigalink/services/farmer_service.dart';

class FarmerProvider extends ChangeNotifier {
  Farmer? _farmer;

  Farmer? get farmer => _farmer;
  FarmerProvider() {
    _farmer = Farmer(
        landSize: 2000,
        name: "Farmer",
        experience: 3,
        status: "Offline",
        location: "Addis Ababa",
        phoneNumber: "+251929146352",
        cropsProduced: [],
        profilePicture: 'profilePicture',
        farmImage: 'farmImage');
    _initFarmer();
  }
  void _initFarmer() async {
    Farmer? farmer = await FarmerService.getFarmer();
    _farmer = farmer;
    notifyListeners();
  }

  void setFarmer(Farmer f) {
    _farmer = f;
    notifyListeners();
  }

  void updateFarmer() async {
    _farmer = await FarmerService.getFarmer();
    notifyListeners();
  }
}
