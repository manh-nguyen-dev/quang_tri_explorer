import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'package:quang_tri_explorer/services/shared_pref.dart';
import 'package:quang_tri_explorer/screens/home/home_screen.dart';
import 'package:quang_tri_explorer/screens/login/login_screen.dart';
import 'package:quang_tri_explorer/screens/onboarding/onboarding_screen.dart';
import 'package:quang_tri_explorer/screens/signup/signup_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPref.init();
  MobileAds.instance.initialize();

  final token = SharedPref.getToken();
  runApp(MyApp(token: token));
}

class MyApp extends StatelessWidget {
  final String? token;

  const MyApp({super.key, this.token});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Quảng Trị Explorer',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: token != null ? const HomeScreen() : const OnboardingScreen(),
      routes: {
        '/signup': (context) => SignupScreen(),
        '/login': (context) => LoginScreen(),
        '/onboarding': (context) => const OnboardingScreen(),
        '/home': (context) => const HomeScreen(),
      },
    );
  }
}
