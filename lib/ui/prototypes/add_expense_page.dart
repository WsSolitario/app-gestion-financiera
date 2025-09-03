import 'package:flutter/material.dart';

const lightSage = Color(0xFFF0F3F0);
const warmGray = Color(0xFFD6D3D1);
const accentColor = Color(0xFFE0E7FF);

class AddExpensePage extends StatelessWidget {
  const AddExpensePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightSage,
      appBar: AppBar(title: const Text('Agregar Gasto')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(decoration: _input('Descripción')),
            const SizedBox(height: 16),
            TextField(
              decoration: _input('Monto total'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            TextField(
              decoration: _input('Fecha'),
              keyboardType: TextInputType.datetime,
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              decoration: _input('Grupo'),
              items: const [
                DropdownMenuItem(value: 'playa', child: Text('Viaje a la playa')),
                DropdownMenuItem(value: 'cena', child: Text('Cena con amigos')),
              ],
              onChanged: (_) {},
            ),
            const SizedBox(height: 20),
            SwitchListTile(
              title: const Text('¿Tiene ticket?'),
              value: false,
              onChanged: (_) {},
            ),
            const SizedBox(height: 24),
            const Text('Distribución',
                style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            _distributionTile('Sofía', 0.5, 25),
            const SizedBox(height: 8),
            _distributionTile('Mateo', 0.5, 25),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: accentColor,
            shape: const StadiumBorder(),
            minimumSize: const Size.fromHeight(48),
          ),
          onPressed: () {},
          child: const Text('Guardar'),
        ),
      ),
    );
  }

  InputDecoration _input(String hint) => InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      );

  Widget _distributionTile(String name, double percent, double amount) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: warmGray.withOpacity(0.2),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          const CircleAvatar(),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name,
                    style: const TextStyle(fontWeight: FontWeight.w600)),
                Text('${(percent * 100).round()}%'),
              ],
            ),
          ),
          SizedBox(
            width: 60,
            child: Text('\$${amount.toStringAsFixed(2)}',
                textAlign: TextAlign.right),
          ),
        ],
      ),
    );
  }
}

