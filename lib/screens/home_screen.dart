import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  // Функция для сброса подписки (для тестов)
  Future<void> _resetSubscription(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('is_premium');

    if (!context.mounted) return;
    Navigator.pushNamedAndRemoveUntil(context, '/onboarding', (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Главная"),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: "Сбросить подписку",
            onPressed: () => _resetSubscription(context),
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.check_circle, size: 80, color: Colors.green),
            const SizedBox(height: 20),
            const Text(
              "Премиум контент доступен!",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: Text(
                "Вы успешно прошли пейвол. При перезапуске приложения вы снова попадете сюда.",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey),
              ),
            ),
          ],
        ),
      ),
    );
  }
}