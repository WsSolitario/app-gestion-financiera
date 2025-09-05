import 'package:flutter/material.dart';

const accentColor = Color(0xFFE6E6FA);
const textSecondary = Color(0xFF6C757D);

class ExpenseTile extends StatelessWidget {
  final String title;
  final String category;
  final double amount;
  const ExpenseTile(
      {super.key,
      required this.title,
      required this.category,
      required this.amount});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const CircleAvatar(backgroundColor: accentColor),
      title: Text(title),
      subtitle: Text(category, style: const TextStyle(color: textSecondary)),
      trailing: Text('\$${amount.toStringAsFixed(2)}',
          style: const TextStyle(fontWeight: FontWeight.bold)),
    );
  }
}
