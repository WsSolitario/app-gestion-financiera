import 'package:flutter/material.dart';

import '../widgets/app_bottom_navigation.dart';

const softSage = Color(0xFFE8EAE6);
const lightLavender = Color(0xFFE6E6FA);
const textSecondary = Color(0xFF6B7280);
const accentColor = Color(0xFFE6E6FA);

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        leading: Padding(
          padding: const EdgeInsets.all(8),
          child: CircleAvatar(
            backgroundImage: NetworkImage(
              'https://lh3.googleusercontent.com/aida-public/AB6AXuA0yggCah09VSrWLQs9C3bO0qaPY6T5EAd4jaE6uIWX4VW8_3P6MvdqvbwlKldSns0Gcdzleo_2swHIoGE3URRxqpJabFv2d57SuoLNgdO0xBxgBZGCAUTZXAFauDXCy2aA9ivvFKXS_v10XQFXaCu1SAwO_K-ilKAq558MMlgEB5gQpLlGPKgCJBi90gHU3nftAnDkkLXTUPMDZxkvE5fpc9d3Q-Cnn_5Q3a50IYEqcprtZpnjEBgxhzw431yXQC4M7gUvioow5Cdr',
            ),
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const SectionTitle('Gastos Recientes'),
          _recentExpenseTile('Cuenta del Restaurante', 'Cena', 45),
          _recentExpenseTile('Supermercado', 'Compras', 78.5),
          _recentExpenseTile('Factura de Electricidad', 'Servicios', 62.25),
          const SectionTitle('Deudas Pendientes'),
          _debtTile('Liam', 'Vacaciones', 25),
          _debtTile('Sophia', 'Alquiler', 50),
          const SectionTitle('Actividad de Grupo'),
          _activityTile('Vacaciones', 'Liam añadió un nuevo gasto.', '2h'),
          _activityTile('Alquiler', 'Sophia pagó su parte.', '4h'),
        ],
      ),
      bottomNavigationBar: const AppBottomNavigation(currentIndex: 1),
    );
  }

  Widget _recentExpenseTile(String title, String cat, double amount) {
    return ListTile(
      leading: const CircleAvatar(backgroundColor: accentColor),
      title: Text(title),
      subtitle: Text(cat),
      trailing: Text('\$${amount.toStringAsFixed(2)}'),
    );
  }

  Widget _debtTile(String name, String cat, double amount) {
    return ListTile(
      leading: const CircleAvatar(),
      title: Text(name),
      subtitle: Text(cat),
      trailing: Text(
        '\$${amount.toStringAsFixed(2)}',
        style: const TextStyle(color: Colors.red),
      ),
    );
  }

  Widget _activityTile(String group, String action, String time) {
    return ListTile(
      leading: const CircleAvatar(backgroundColor: accentColor),
      title: Text(group),
      subtitle: Text(action),
      trailing: Text(time, style: const TextStyle(fontSize: 12)),
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String text;
  const SectionTitle(this.text, {super.key});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 24, bottom: 8),
      child: Text(
        text,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }
}
