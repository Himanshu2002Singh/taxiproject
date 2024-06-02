import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

import 'providers/auth_provider.dart';
import 'providers/taxi_provider.dart';
import 'services/auth_service.dart';
import 'services/taxi_service.dart';
import 'services/booking_service.dart';
import 'services/payment_service.dart';

import 'screens/auth_screen.dart';
import 'screens/home_screen.dart';
import 'screens/taxi_list_screen.dart';
import 'screens/booking_screen.dart';
import 'screens/map_screen.dart';
import 'screens/subscription_screen.dart';
import 'screens/user_dashboard_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Initialize Firebase

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => TaxiProvider()),
        Provider<AuthService>(create: (_) => AuthService()),
        Provider<TaxiService>(create: (_) => TaxiService()),
        Provider<BookingService>(create: (_) => BookingService()),
        Provider<PaymentService>(create: (_) => PaymentService()..init()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Uttrakhand Taxi App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => AuthScreen(),
        '/home': (context) => HomeScreen(),
        '/taxi-list': (context) => TaxiListScreen(),
        '/booking': (context) {
          // Extracting userId from arguments when navigating to BookingScreen
          final args = ModalRoute.of(context)!.settings.arguments;
          final userId =
              args != null ? (args as Map<String, dynamic>)['userId'] : null;
          return BookingScreen(userId: userId);
        },
        '/map': (context) => MapScreen(),
        '/subscription': (context) => SubscriptionScreen(),
        '/dashboard': (context) => UserDashboardScreen(),
      },
    );
  }
}
