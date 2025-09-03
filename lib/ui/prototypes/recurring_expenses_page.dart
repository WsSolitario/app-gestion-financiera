import 'package:flutter/material.dart';

class RecurringExpensesPage extends StatelessWidget {
  const RecurringExpensesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Gastos Recurrentes')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _item('Alquiler', '100 € · Mensual', 'Próximo pago: 01/08/2024'),
          _item('Servicios públicos', '50 € · Mensual',
              'Próximo pago: 15/07/2024'),
          _item('Suscripción de streaming', '20 € · Semanal',
              'Próximo pago: 28/07/2024'),
          _item('Gimnasio', '30 € · Mensual', 'Próximo pago: 10/08/2024'),
        ],
      ),
      bottomNavigationBar: _bottomBar(),
    );
  }

  static Widget _item(String title, String subtitle, String nextPayment) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        title:
            Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(subtitle),
            Text(nextPayment,
                style: const TextStyle(fontSize: 12, color: Colors.grey)),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.edit_outlined)),
            IconButton(onPressed: () {}, icon: const Icon(Icons.delete_outline)),
          ],
        ),
      ),
    );
  }

  static Widget _bottomBar() {
    return BottomAppBar(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.add),
              label: const Text('Agregar Gasto Recurrente'),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(48),
                shape: const StadiumBorder(),
              ),
            ),
          ),
          BottomNavigationBar(
            currentIndex: 2,
            onTap: (_) {},
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.group_outlined),
                label: 'Grupos',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.dashboard_outlined),
                label: 'Dashboard',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.payments_outlined),
                label: 'Pagos',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person_outline),
                label: 'Perfil',
              ),
            ],
          ),
        ],
      ),
    );
  }
}

