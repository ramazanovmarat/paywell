import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_paywall/widgets/subscription_card.dart';

class PaywallScreen extends StatefulWidget {
  const PaywallScreen({super.key});

  @override
  State<PaywallScreen> createState() => _PaywallScreenState();
}

class _PaywallScreenState extends State<PaywallScreen> {
  // 0 - Месяц, 1 - Год
  int selectedIndex = 1;
  bool isLoading = false;

  Future<void> _buySubscription() async {
    setState(() => isLoading = true);

    // Эмуляция задержки сети (1 секунда)
    await Future.delayed(const Duration(seconds: 1));

    // Сохраняем состояние "Куплено"
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('is_premium', true);

    if (!mounted) return;

    // Переходим на главный экран, удаляя историю (чтобы нельзя было вернуться назад на пейвол)
    Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.pop(context), // Возможность закрыть, если нужно
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Откройте полный доступ",
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text("Выберите план подписки:", style: TextStyle(fontSize: 18, color: Colors.grey)),
            const SizedBox(height: 30),

            // Карточка "Месяц"
            SubscriptionCard(
              title: "1 Месяц",
              price: "399 ₽",
              subtitle: "Оплата ежемесячно",
              isSelected: selectedIndex == 0, // Проверяем, выбран ли этот индекс
              onTap: () {
                setState(() => selectedIndex = 0); // Меняем состояние в родителе
              },
            ),

            const SizedBox(height: 16),

            // Карточка "Год"
            SubscriptionCard(
              title: "1 Год",
              price: "1990 ₽",
              subtitle: "Выгода 50%",
              isBestValue: true,
              isSelected: selectedIndex == 1, // Проверяем, выбран ли этот индекс
              onTap: () {
                setState(() => selectedIndex = 1); // Меняем состояние в родителе
              },
            ),

            const Spacer(),

            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                onPressed: isLoading ? null : _buySubscription,
                child: isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text("Продолжить", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              ),
            ),
            const SizedBox(height: 10),
            const Center(
              child: Text(
                "Нажимая продолжить, вы соглашаетесь с условиями (эмуляция).",
                style: TextStyle(fontSize: 10, color: Colors.grey),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}