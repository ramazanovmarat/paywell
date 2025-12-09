import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_paywall/screens/home_screen.dart';
import 'package:test_paywall/screens/onboarding_screen.dart';
import 'package:test_paywall/screens/paywall_screen.dart';

void main() async {
  // Гарантируем инициализацию движка Flutter перед выполнением асинхронного кода
  WidgetsFlutterBinding.ensureInitialized();

  // Проверяем состояние подписки перед запуском приложения
  final prefs = await SharedPreferences.getInstance();
  final bool isPremium = prefs.getBool('is_premium') ?? false;

  runApp(MyApp(startWithPremium: isPremium));
}

class MyApp extends StatelessWidget {
  final bool startWithPremium;

  const MyApp({super.key, required this.startWithPremium});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simple Subscription App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      // Если подписка есть — сразу Главный экран, иначе — Онбординг
      initialRoute: startWithPremium ? '/home' : '/onboarding',
      routes: {
        '/onboarding': (context) => const OnboardingScreen(),
        '/paywall': (context) => const PaywallScreen(),
        '/home': (context) => const HomeScreen(),
      },
    );
  }
}