import 'package:flutter/foundation.dart';
import '../models/trip.dart';
import '../services/api_service.dart';

class TripListViewModel extends ChangeNotifier {
  List<Trip> _trips = [];
  bool _isLoading = false;
  String? _error;

  List<Trip> get trips => _trips;
  bool get isLoading => _isLoading;
  bool get isloading => _isLoading;
  String? get error => _error;

  Future<void> loadTrips() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _trips = await ApiService.getAllTrips();
    } catch (e) {
      _error = e.toString().replaceFirst('Exception: ', '');
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<bool> deleteTrip(int id) async {
    try {
      await ApiService.deleteTrip(id);
      _trips.removeWhere((trip) => trip.id == id);
      notifyListeners();
      return true;
    } catch (e) {
      _error = e.toString().replaceFirst('Exception: ', '');
      notifyListeners();
      return false;
    }
  }

  void addTrip(Trip trip) {
    _trips.insert(0, trip);
    notifyListeners();
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }
}

typedef TripListViewmodel = TripListViewModel;
