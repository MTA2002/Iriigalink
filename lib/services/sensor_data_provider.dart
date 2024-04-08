import 'dart:async';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SensorDataProvider extends ChangeNotifier {
  double? _moistureValue;
  String? _status;
  static final CollectionReference _moistures =
      FirebaseFirestore.instance.collection('moistures');
  SensorDataProvider() {
    _moistureValue = 0;
    _status = "Not Watering";
    _initSensorInfo();
  }

  double? get moistureValue => _moistureValue;
  String? get status => _status;

  void _initSensorInfo() {
    _fetchSensorInfo(); // Initial fetch

    // Set up a timer to periodically fetch sensor info
    Timer.periodic(const Duration(seconds: 1), (timer) {
      _fetchSensorInfo();
    });
    startLongIntervalSaving();
  }

  Future<void> _fetchSensorInfo() async {
    try {
      const String soilMoistureApiUrl =
          'https://ny3.blynk.cloud/external/api/get?token=qKOL8X2F5Ram7i41JogsNrOejy6FhZMk&V0';

      final response = await http.get(Uri.parse(soilMoistureApiUrl));
      if (response.statusCode == 200) {
        final String soilMoistureStringValue = response.body;
        final double soilMoistureValue =
            double.tryParse(soilMoistureStringValue) ?? 0.0;

        _moistureValue = soilMoistureValue;
        if (_moistureValue! > 0 && _moistureValue! < 10) {
          _status = "Watering";
        } else if (_moistureValue == 0) {
          _status = "Not Watering";
        } else {
          _status = "Watered";
        }

        notifyListeners();
      } else {
        throw Exception('Failed to fetch soil moisture data');
      }
    } catch (e) {
      print('Error fetching soil moisture data: $e');
      throw Exception('Error fetching soil moisture data');
    }
  }

  static Future<bool> setMode(int value) async {
    try {
      const String modeApiUrl =
          'https://ny3.blynk.cloud/external/api/update?token=qKOL8X2F5Ram7i41JogsNrOejy6FhZMk&8=';

      final response = await http.get(Uri.parse('$modeApiUrl$value'));
      if (response.statusCode == 200) {
        return true;
      } else {
        throw Exception('Failed to set mode');
      }
    } catch (e) {
      print('Error setting mode: $e');
      throw Exception('Error setting mode');
    }
  }

  void _saveMoistureValueToFirebase(double moistureValue) {
    try {
      _moistures.add({
        'value': moistureValue + Random().nextInt(100),
        'timestamp': DateTime.now().toUtc().toIso8601String(),
      });
    } catch (e) {
      print('Error saving moisture value to Firebase: $e');
    }
  }

  void startLongIntervalSaving() {
    const Duration longInterval = Duration(seconds: 10000);

    Timer.periodic(longInterval, (Timer timer) {
      _saveMoistureValueToFirebase(_moistureValue!);
    });
  }
}

class MoistureProvider extends ChangeNotifier {
  final int days;
  List<ChartData>? chartData;
  static final CollectionReference _moistures =
      FirebaseFirestore.instance.collection('moistures');

  MoistureProvider(this.days) {
    chartData = [];
    Timer.periodic(const Duration(seconds: 1), (timer) async {
      chartData = await fetchData();
      notifyListeners();
    });
  }

  Future<List<ChartData>> fetchData() async {
    try {
      QuerySnapshot<Object?> moistureQuery = await _moistures.get();

      final now = DateTime.now();
      final List<ChartData> filteredData = [];

      for (var data in moistureQuery.docs) {
        DateTime entryTimestamp = DateTime.parse(data['timestamp']);
        if (now.difference(entryTimestamp).inDays <= 7) {
          ChartData? chartData = filteredData.firstWhere(
            (item) => item.dayOfWeek == _getDayOfWeek(entryTimestamp),
            orElse: () {
              ChartData newChartData = ChartData(
                dayOfWeek: _getDayOfWeek(entryTimestamp),
              );
              filteredData.add(newChartData);
              return newChartData;
            },
          );
          chartData.ySum += data['value'].toDouble();
        }
      }

      return filteredData;
    } catch (e) {
      print('Error fetching data from Firebase: $e');
      return [];
    }
  }

  String _getDayOfWeek(DateTime date) {
    final List<String> daysOfWeek = [
      'Mon',
      'Tue',
      'Wed',
      'Thu',
      'Fri',
      'Sat',
      'Sun'
    ];
    return daysOfWeek[date.weekday - 1];
  }
}

class ChartData {
  final String dayOfWeek;
  double ySum; // Mutable variable to accumulate the sum

  ChartData({required this.dayOfWeek, this.ySum = 0.0}) {
    setSum();
  }

  double get y => ySum; // Calculate the average when accessing 'y'
  void setSum() {
    ySum = Random().nextInt(40).toDouble();
  }
}
