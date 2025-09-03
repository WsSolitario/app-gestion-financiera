import 'package:flutter/material.dart';

class PaymentsPage extends StatelessWidget {
  const PaymentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pagos')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const SectionTitle('Tus deudas'),
          _debtRow('Maria', 'Debes 12,50 €', true),
          _debtRow('Juan', 'Debes 25,00 €', true),
          const SectionTitle('Pagos realizados'),
          _debtRow('Maria', 'Pagaste 12,50 €', false),
          _debtRow('Juan', 'Pagaste 25,00 €', false),
          const SectionTitle('Pagos por aprobar'),
          _approveCard('Maria', 12.50),
          _approveCard('Juan', 25.00),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: [
            const Spacer(),
            ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.add),
              label: const Text('Nuevo pago'),
              style: ElevatedButton.styleFrom(shape: const StadiumBorder()),
            ),
          ],
        ),
      ),
    );
  }

  static Widget _debtRow(String name, String text, bool pending) {
    final color = pending ? Colors.amber[100] : Colors.green[100];
    final label = pending ? 'Pendiente' : 'Pagado';
    final labelColor = pending ? Colors.amber[700] : Colors.green[700];
    return ListTile(
      leading: const CircleAvatar(),
      title: Text('A $name'),
      subtitle: Text(text),
      trailing: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
        decoration:
            BoxDecoration(color: color, borderRadius: BorderRadius.circular(12)),
        child: Text(label, style: TextStyle(color: labelColor, fontSize: 12)),
      ),
    );
  }

  static Widget _approveCard(String name, double amount) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const CircleAvatar(),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('$name te pagó'),
                    Text('${amount.toStringAsFixed(2)} €',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18)),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {},
                    child: const Text('Rechazar'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    child: const Text('Aprobar'),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
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
      child: Text(text,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
    );
  }
}

