import 'dart:convert';
import 'dart:io' show Platform;
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../models/trip.dart';

class ApiService {
  static String get defaultBaseUrl {
    if (kIsWeb) return 'http://localhost:3000/api';
    try {
      if (Platform.isAndroid) return 'http://10.0.2.2:3000/api';
    } catch (_) {}
    return 'http://localhost:3000/api';
  }

  static String baseUrl = defaultBaseUrl;

  static Future<List<Trip>> getAllTrips() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/trips'));
      if (response.statusCode == 200) {
        final List<dynamic> jsonList = jsonDecode(response.body) as List<dynamic>;
        return jsonList
            .map((item) => Trip.fromJson(item as Map<String, dynamic>))
            .toList();
      } else {
        throw Exception('Failed to fetch trips (Status ${response.statusCode})');
      }
    } catch (e) {
      throw Exception('Error loading trips: $e');
    }
  }

  static Future<List<Trip>> getAlltTrips() => getAllTrips();

  static Future<Trip> getTripById(int id) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/trips/$id'));
      if (response.statusCode == 200) {
        return Trip.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
      } else if (response.statusCode == 404) {
        throw Exception('Trip not found');
      } else {
        throw Exception(
            'Failed to fetch trip details (Status ${response.statusCode})');
      }
    } catch (e) {
      throw Exception('Error loading trip: $e');
    }
  }

  static Future<Trip> createTrip(Trip trip) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/trips'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(trip.toJson()),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return Trip.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
      } else {
        throw Exception('Failed to create trip (Status ${response.statusCode})');
      }
    } catch (e) {
      throw Exception('Error creating trip: $e');
    }
  }

  static Future<void> deleteTrip(int id) async {
    try {
      final response = await http.delete(Uri.parse('$baseUrl/trips/$id'));
      if (response.statusCode != 200 && response.statusCode != 204) {
        throw Exception('Failed to delete trip (Status ${response.statusCode})');
      }
    } catch (e) {
      throw Exception('Error deleting trip: $e');
    }
  }

  static Future<void> deletetrip(int id) => deleteTrip(id);
}
