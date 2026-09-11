import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'viewmodels/trip_list_viewmodel.dart';
import 'viewmodels/trip_detail_viewmodel.dart';
import 'viewmodels/add_trip_viewmodel.dart';
import 'views/trip_list_screen.dart';

void main() {
  runApp(const MyApp());
}

class SmoothScrollBehavior extends MaterialScrollBehavior {
  const SmoothScrollBehavior();

  @override
  ScrollPhysics getScrollPhysics(BuildContext context) {
    return const BouncingScrollPhysics(
      parent: AlwaysScrollableScrollPhysics(),
    );
  }

  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        PointerDeviceKind.trackpad,
        PointerDeviceKind.stylus,
      };
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TripListViewModel()),
        ChangeNotifierProvider(create: (_) => TripDetailViewModel()),
        ChangeNotifierProvider(create: (_) => AddTripViewModel()),
      ],
      child: MaterialApp(
        title: 'Travel Journal',
        scrollBehavior: const SmoothScrollBehavior(),
        theme: ThemeData(
          useMaterial3: true,
          brightness: Brightness.dark,
          scaffoldBackgroundColor: const Color(0xFF1a1a1a),
          colorScheme: const ColorScheme.dark(
            primary: Color(0xFF2E5090),
            secondary: Color(0xFFF97316),
            surface: Color(0xFF242424),
          ),
          appBarTheme: const AppBarTheme(
            backgroundColor: Color(0xFF2E5090),
            foregroundColor: Colors.white,
            elevation: 0,
          ),
        ),
        home: const TripListScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}