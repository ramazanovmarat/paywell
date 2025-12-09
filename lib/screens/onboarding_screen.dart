import 'package:flutter/material.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              const Icon(Icons.sports_basketball, size: 100, color: Colors.blue),
              const SizedBox(height: 32),
              const Text(
                "Добро пожаловать!",
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              const Text(
                "Это лучшее приложение для демонстрации экрана подписки и сохранения состояния.",
                style: TextStyle(fontSize: 16, color: Colors.grey),
                textAlign: TextAlign.center,
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green, // Цвет кнопки зеленый
                    foregroundColor: Colors.black, // Цвет текста черный
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10), // Округление краев 10
                    ),
                  ),
                  onPressed: () {
                    // Переход на Пейвол
                    Navigator.pushNamed(context, '/paywall');
                  },
                  child: const Text("Продолжить", style: TextStyle(fontSize: 18)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}