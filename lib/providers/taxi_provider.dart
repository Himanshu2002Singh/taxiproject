import 'package:flutter/material.dart';
import '../services/taxi_service.dart';
import '../models/taxi.dart';

class TaxiProvider with ChangeNotifier {
  final TaxiService _taxiService = TaxiService();
  List<Taxi> _taxis = [];

  List<Taxi> get taxis => _taxis;

  Future<void> fetchTaxis() async {
    _taxis = await _taxiService.getTaxis().first;
    notifyListeners();
  }
}
