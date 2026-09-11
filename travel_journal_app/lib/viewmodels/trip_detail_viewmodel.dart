import 'package:flutter/foundation.dart';
import '../models/trip.dart';
import '../services/api_service.dart';

class TripDetailViewModel extends ChangeNotifier {
  Trip? _trip;
  bool _isLoading = false;
  String? _error;

  Trip? get trip => _trip;
  bool get isLoading => _isLoading;
  bool get isloading => _isLoading;
  String? get error => _error;

  Future<void> loadTrip(int id) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _trip = await ApiService.getTripById(id);
    } catch (e) {
      _error = e.toString().replaceFirst('Exception: ', '');
    }

    _isLoading = false;
    notifyListeners();
  }

  void setTrip(Trip trip) {
    _trip = trip;
    notifyListeners();
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }
}

typedef TripDetailViewmodel = TripDetailViewModel;
