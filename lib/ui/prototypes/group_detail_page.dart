import 'package:flutter/material.dart';

const backgroundColor = Color(0xFFF8F9FA);
const primaryColor = Color(0xFFD8E2DC);
const textSecondary = Color(0xFF6C757D);
const accentColor = Color(0xFFE6E6FA);
const accentColorDark = Color(0xFFB5B5D1);
const successColor = Color(0xFFA3B8A3);
const warningColor = Color(0xFFDCA3A3);

class GroupDetailPage extends StatelessWidget {
  const GroupDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: const Text('Viaje a la playa'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {},
        ),
        actions: [IconButton(icon: const Icon(Icons.more_horiz), onPressed: () {})],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text('Gastos recientes',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          _expenseTile('Cena en el restaurante', 'Comida', 85),
          _expenseTile('Alquiler de coche', 'Transporte', 150),
          _expenseTile('Hotel', 'Alojamiento', 300),
          const SizedBox(height: 24),
          const Text('Miembros del grupo',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          const CircleAvatarGroup(
            urls: [
              'https://lh3.googleusercontent.com/aida-public/AB6AXuABP1Cg2tF-nDmdwQL3b_jsEgAoaJT67v6wLbXu-vLrc2d6sKJjkplSgWuB-VvPGTG0SDHZ_tg1lIlKnjcE8aYokzLwd8kRqgT70ExQF471pLKdgp6tt8IFmauuOCap9lrsYQfo0BpBvGFgozK6IGczGGJJo0XzCJa658rggmxrN3qmWEndVjjuU0hgdvqiL4WgMqAiM1-vi1SnW4dPhKR6JXTcI6F3NZPV0lGDZujLHL3gMCkea15-41W48rlC_KQ-FGqA9ORTMVZy',
              'https://lh3.googleusercontent.com/aida-public/AB6AXuBlTlR-2p8s0nM3uRXNe6zFzmnnfSBScA28w3Xskzrs9XYPMvZ2HqKqhLjRnB0txp8Lv73B7U2Sfy1w1CEwH77rcMLP-l2zum5Qg1ks6xhut8Hk8clrVglyXRuiQ1ZZna55S6BtSgHGwaqBK9b4wp-oKe9YxVtKz9M53zLAVdX2f_chGcl_iCIHET_sNPLPBf7GeZA4zgZK22H7SolhTUZl_yqJVwtwVa9xyvZYcj-sxp3XfipK0Fhj7rDgaSo_sdQe6xPg287doUOf',
              'https://lh3.googleusercontent.com/aida-public/AB6AXuB5YxzYD-pDJtQDXhQpGdUYoQcli6isDhrjf12_srsE2UJZ75pR8uZNTNrqIveHIuTnBHDnOtYUgAxyH_7ygk5zt83kmUD7V-W5wmNb4n-tbi2H4z319QGD2nXNWrLYP3viYEwJX33DAnEB0yw-0QJJjcCsgEg5ZbqFnF3Pi5JSTQBhuCANr4BnAyaCZ3v4uajtTo49yusLZsl0hjZmFqfSEJKqBc87GMBCBjnJd2FQCeec3PSfKl4jnDpD8nnfXsH8Nb2NcIJWLjan',
            ],
            extraCount: 2,
          ),
          const SizedBox(height: 24),
          const Text('Resumen de balances',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          _balanceTile('Sofía', -25),
          _balanceTile('Carlos', -15),
          _balanceTile('Javier', 40),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        child: Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: accentColor,
                  shape: const StadiumBorder(),
                ),
                child: const Text('Añadir gasto'),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  shape: const StadiumBorder(),
                  side: const BorderSide(color: Colors.black),
                ),
                child: const Text('Ver detalles'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _expenseTile(String title, String category, double amount) {
  return ListTile(
    leading: const CircleAvatar(backgroundColor: accentColor),
    title: Text(title),
    subtitle: Text(category, style: const TextStyle(color: textSecondary)),
    trailing: Text('\\$${amount.toStringAsFixed(2)}',
        style: const TextStyle(fontWeight: FontWeight.bold)),
  );
}

Widget _balanceTile(String name, double amount) {
  final isPositive = amount >= 0;
  final color = isPositive ? successColor : warningColor;
  final text = isPositive ? 'Te debe' : 'Debes';
  return ListTile(
    leading: const CircleAvatar(),
    title: Text(name),
    subtitle: Text(text, style: TextStyle(color: color)),
    trailing: Text('\\$${amount.abs().toStringAsFixed(2)}',
        style: TextStyle(fontWeight: FontWeight.bold, color: color)),
  );
}

class CircleAvatarGroup extends StatelessWidget {
  final List<String> urls;
  final int extraCount;
  const CircleAvatarGroup({super.key, required this.urls, this.extraCount = 0});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: Stack(
        children: [
          for (int i = 0; i < urls.length; i++)
            Positioned(
              left: i * 28,
              child: CircleAvatar(
                radius: 24,
                backgroundImage: NetworkImage(urls[i]),
              ),
            ),
          if (extraCount > 0)
            Positioned(
              left: urls.length * 28,
              child: CircleAvatar(
                radius: 24,
                backgroundColor: accentColor,
                child: Text('+$extraCount',
                    style: const TextStyle(fontWeight: FontWeight.bold)),
              ),
            ),
        ],
      ),
    );
  }
}

