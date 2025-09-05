import 'package:flutter/material.dart';

const successColor = Color(0xFFA3B8A3);
const warningColor = Color(0xFFDCA3A3);

class BalanceTile extends StatelessWidget {
  final String name;
  final double amount;
  const BalanceTile({super.key, required this.name, required this.amount});

  @override
  Widget build(BuildContext context) {
    final isPositive = amount >= 0;
    final color = isPositive ? successColor : warningColor;
    final text = isPositive ? 'Te debe' : 'Debes';
    return ListTile(
      leading: const CircleAvatar(),
      title: Text(name),
      subtitle: Text(text, style: TextStyle(color: color)),
      trailing: Text('\$${amount.abs().toStringAsFixed(2)}',
          style: TextStyle(fontWeight: FontWeight.bold, color: color)),
    );
  }
}
