import 'package:flutter_test/flutter_test.dart';
import 'package:travel_journal_app/models/trip.dart';

void main() {
  group('Trip Model Tests', () {
    test('Trip.fromJson parses snake_case correctly', () {
      final json = {
        'id': 1,
        'title': 'Paris Getaway',
        'destination': 'Paris, France',
        'start_date': '2026-05-01',
        'end_date': '2026-05-10',
        'notes': 'Visiting the Louvre and Eiffel Tower',
        'image_url': 'https://images.unsplash.com/photo-paris.jpg',
      };

      final trip = Trip.fromJson(json);

      expect(trip.id, 1);
      expect(trip.title, 'Paris Getaway');
      expect(trip.destination, 'Paris, France');
      expect(trip.startDate, '2026-05-01');
      expect(trip.endDate, '2026-05-10');
      expect(trip.notes, 'Visiting the Louvre and Eiffel Tower');
      expect(trip.imageUrl, 'https://images.unsplash.com/photo-paris.jpg');
    });

    test('Trip.fromJson parses camelCase fallback correctly', () {
      final json = {
        'id': '2',
        'title': 'Tokyo Adventure',
        'destination': 'Tokyo, Japan',
        'startDate': '2026-06-01',
        'endDate': '2026-06-15',
        'notes': 'Exploring Shibuya and Shinjuku',
        'imageUrl': 'https://images.unsplash.com/photo-tokyo.jpg',
      };

      final trip = Trip.fromJson(json);

      expect(trip.id, 2);
      expect(trip.title, 'Tokyo Adventure');
      expect(trip.destination, 'Tokyo, Japan');
      expect(trip.startDate, '2026-06-01');
      expect(trip.endDate, '2026-06-15');
      expect(trip.notes, 'Exploring Shibuya and Shinjuku');
      expect(trip.imageUrl, 'https://images.unsplash.com/photo-tokyo.jpg');
    });

    test('Trip.toJson generates expected map for API creation', () {
      const trip = Trip(
        id: 0,
        title: 'Kyoto Temples',
        destination: 'Kyoto, Japan',
        startDate: '2026-07-01',
        endDate: '2026-07-07',
        notes: 'Fushimi Inari and Arashiyama',
        imageUrl: 'https://images.unsplash.com/photo-kyoto.jpg',
      );

      final json = trip.toJson();

      expect(json['title'], 'Kyoto Temples');
      expect(json['destination'], 'Kyoto, Japan');
      expect(json['startDate'], '2026-07-01');
      expect(json['endDate'], '2026-07-07');
      expect(json['notes'], 'Fushimi Inari and Arashiyama');
      expect(json['imageUrl'], 'https://images.unsplash.com/photo-kyoto.jpg');
    });
  });
}
