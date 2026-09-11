import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/trip.dart';
import '../viewmodels/trip_list_viewmodel.dart';
import 'add_trip_screen.dart';
import 'trip_detail_screen.dart';
import '../widgets/trip_card.dart';

class TripListScreen extends StatefulWidget {
  const TripListScreen({super.key});

  @override
  State<TripListScreen> createState() => _TripListScreenState();
}

class _TripListScreenState extends State<TripListScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        context.read<TripListViewModel>().loadTrips();
      }
    });
  }

  Future<void> _confirmDelete(BuildContext context, Trip trip) async {
    final listViewModel = context.read<TripListViewModel>();
    final messenger = ScaffoldMessenger.of(context);

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF242424),
        title: const Text('Delete Trip', style: TextStyle(color: Colors.white)),
        content: Text(
          'Are you sure you want to delete "${trip.title}"?',
          style: const TextStyle(color: Colors.white70),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Cancel', style: TextStyle(color: Colors.grey)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Delete', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      final success = await listViewModel.deleteTrip(trip.id);
      messenger.showSnackBar(
        SnackBar(
          content: Text(
            success
                ? 'Trip deleted'
                : 'Failed to delete trip: ${listViewModel.error ?? "Unknown error"}',
          ),
          backgroundColor: success ? Colors.green[700] : Colors.red[700],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: [
            Icon(Icons.flight_takeoff, color: Color(0xFFF97316)),
            SizedBox(width: 10),
            Text(
              'Travel Journal',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        backgroundColor: const Color(0xFF2E5090),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            tooltip: 'Refresh Trips',
            onPressed: () => context.read<TripListViewModel>().loadTrips(),
          ),
        ],
      ),
      body: Consumer<TripListViewModel>(
        builder: (context, viewModel, child) {
          if (viewModel.isLoading && viewModel.trips.isEmpty) {
            return const Center(
              child: CircularProgressIndicator(
                color: Color(0xFFF97316),
              ),
            );
          }

          if (viewModel.error != null && viewModel.trips.isEmpty) {
            return Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.error_outline,
                      size: 56,
                      color: Colors.redAccent,
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Failed to load trips',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: const Color(0xFF242424),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.white12),
                      ),
                      child: Text(
                        viewModel.error!,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 13,
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF2E5090),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 12,
                        ),
                      ),
                      onPressed: () => viewModel.loadTrips(),
                      icon: const Icon(Icons.refresh, color: Colors.white),
                      label: const Text(
                        'Try Again',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }

          if (viewModel.trips.isEmpty) {
            return RefreshIndicator(
              onRefresh: () => viewModel.loadTrips(),
              color: const Color(0xFFF97316),
              child: ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.6,
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(32.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.map_outlined,
                              size: 72,
                              color: Colors.grey[600],
                            ),
                            const SizedBox(height: 16),
                            const Text(
                              'No trips added yet',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Start documenting your travels by creating your first trip!',
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.grey[400]),
                            ),
                            const SizedBox(height: 24),
                            ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFFF97316),
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 24,
                                  vertical: 12,
                                ),
                              ),
                              onPressed: () async {
                                final listVm = context.read<TripListViewModel>();
                                final result = await Navigator.push<Trip?>(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const AddTripScreen(),
                                  ),
                                );
                                if (result != null) {
                                  listVm.loadTrips();
                                }
                              },
                              icon: const Icon(Icons.add, color: Colors.white),
                              label: const Text(
                                'Add First Trip',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: () => viewModel.loadTrips(),
            color: const Color(0xFFF97316),
            child: ListView.builder(
              physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics(),
              ),
              padding: const EdgeInsets.symmetric(vertical: 12),
              itemCount: viewModel.trips.length,
              itemBuilder: (context, index) {
                final trip = viewModel.trips[index];
                return TripCard(
                  trip: trip,
                  onTap: () async {
                    final listVm = context.read<TripListViewModel>();
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TripDetailScreen(tripId: trip.id),
                      ),
                    );
                    listVm.loadTrips();
                  },
                  onDelete: () => _confirmDelete(context, trip),
                );
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          final listVm = context.read<TripListViewModel>();
          final result = await Navigator.push<Trip?>(
            context,
            MaterialPageRoute(
              builder: (context) => const AddTripScreen(),
            ),
          );
          if (result != null) {
            listVm.loadTrips();
          }
        },
        backgroundColor: const Color(0xFFF97316),
        icon: const Icon(Icons.add, color: Colors.white),
        label: const Text(
          'New Trip',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
