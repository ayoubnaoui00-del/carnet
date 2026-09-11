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
          brightness: Brightness.light,
          scaffoldBackgroundColor: Colors.transparent,
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFF1B4332),
            primary: const Color(0xFF1B4332),
            secondary: const Color(0xFFD97706),
            surface: Colors.white,
          ),
          appBarTheme: const AppBarTheme(
            backgroundColor: Color(0xFF1B4332),
            foregroundColor: Colors.white,
            elevation: 0,
            centerTitle: false,
          ),
        ),
        home: const TripListScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}