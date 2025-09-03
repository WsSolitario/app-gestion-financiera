import 'package:flutter/material.dart';

class AddRecurringExpensePage extends StatelessWidget {
  const AddRecurringExpensePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nuevo gasto recurrente'),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              decoration: _input('Descripción'),
            ),
            const SizedBox(height: 16),
            TextField(
              decoration: _input('Monto'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<String>(
                    decoration: _input('Frecuencia'),
                    items: const [
                      DropdownMenuItem(value: 'Semanal', child: Text('Semanal')),
                      DropdownMenuItem(value: 'Mensual', child: Text('Mensual')),
                      DropdownMenuItem(value: 'Anual', child: Text('Anual')),
                    ],
                    onChanged: (_) {},
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: TextField(
                    decoration: _input('Fecha de inicio'),
                    keyboardType: TextInputType.datetime,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              decoration: _input('Grupo'),
              items: const [
                DropdownMenuItem(value: 'playa', child: Text('Viaje a la playa')),
                DropdownMenuItem(value: 'depto', child: Text('Departamento')),
                DropdownMenuItem(value: 'amigos', child: Text('Salida de amigos')),
              ],
              onChanged: (_) {},
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              decoration: _input('Distribución del monto'),
              items: const [
                DropdownMenuItem(value: 'equitativa', child: Text('Equitativa')),
                DropdownMenuItem(value: 'porcentaje', child: Text('Porcentaje')),
                DropdownMenuItem(value: 'monto', child: Text('Monto fijo')),
              ],
              onChanged: (_) {},
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            minimumSize: const Size.fromHeight(48),
            shape: const StadiumBorder(),
          ),
          child: const Text('Guardar Gasto'),
        ),
      ),
    );
  }

  InputDecoration _input(String label) => InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      );
}

