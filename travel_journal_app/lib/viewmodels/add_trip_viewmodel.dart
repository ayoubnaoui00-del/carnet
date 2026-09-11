import 'package:flutter/foundation.dart';
import '../models/trip.dart';
import '../services/api_service.dart';

class AddTripViewModel extends ChangeNotifier {
  bool _isLoading = false;
  String? _error;
  Trip? _createdTrip;

  bool get isLoading => _isLoading;
  bool get isloading => _isLoading;
  String? get error => _error;
  Trip? get createdTrip => _createdTrip;

  Future<bool> createTrip({
    required String title,
    required String destination,
    required String startDate,
    required String endDate,
    required String notes,
    String? imageUrl,
  }) async {
    _isLoading = true;
    _error = null;
    _createdTrip = null;
    notifyListeners();

    try {
      final trip = Trip(
        id: 0,
        title: title.trim(),
        destination: destination.trim(),
        startDate: startDate.trim(),
        endDate: endDate.trim(),
        notes: notes.trim(),
        imageUrl: (imageUrl != null && imageUrl.trim().isNotEmpty)
            ? imageUrl.trim()
            : null,
      );

      _createdTrip = await ApiService.createTrip(trip);
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _error = e.toString().replaceFirst('Exception: ', '');
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  void clearError() {
    _error = null;
    _createdTrip = null;
    notifyListeners();
  }
}

typedef AddTripViewmodel = AddTripViewModel;
