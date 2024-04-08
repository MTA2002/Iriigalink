import 'package:flutter/material.dart';
import 'package:irrigalink/models/distributor_model.dart';
import 'package:irrigalink/services/distributorService.dart';

class DistributorProvider extends ChangeNotifier {
  Distributor? _distributor;

  Distributor? get distributor => _distributor;
  DistributorProvider() {
    _distributor = Distributor(
        id: '',
        name: "Distributor",
        experience: 3,
        status: "Offline",
        location: "Addis Ababa",
        phoneNumber: "+251929146352",
        cropsSelled: [],
        profilePicture: 'profilePicture',
        storeImage: 'farmImage');
    _initDistributor();
  }
  void _initDistributor() async {
    Distributor? dist = await DistributorService.getDistributor();
    _distributor = dist;
    notifyListeners();
  }

  void setDistributor(Distributor d) {
    _distributor = d;
    notifyListeners();
  }
}
