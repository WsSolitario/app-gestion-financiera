import 'package:flutter/material.dart';
import '../../widgets/circle_avatar_group.dart';
import '../../widgets/expense_tile.dart';
import '../../widgets/balance_tile.dart';
import '../../widgets/app_bottom_navigation.dart';

const backgroundColor = Color(0xFFF8F9FA);
const accentColor = Color(0xFFE6E6FA);

class GroupDetailView extends StatelessWidget {
  const GroupDetailView({super.key});

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
        actions: [
          IconButton(icon: const Icon(Icons.more_horiz), onPressed: () {}),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          Text('Gastos recientes',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          SizedBox(height: 8),
          ExpenseTile(
              title: 'Cena en el restaurante',
              category: 'Comida',
              amount: 85),
          ExpenseTile(
              title: 'Alquiler de coche',
              category: 'Transporte',
              amount: 150),
          ExpenseTile(
              title: 'Hotel',
              category: 'Alojamiento',
              amount: 300),
          SizedBox(height: 24),
          Text('Miembros del grupo',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          SizedBox(height: 8),
          CircleAvatarGroup(
            urls: [
              'https://lh3.googleusercontent.com/aida-public/AB6AXuABP1Cg2tF-nDmdwQL3b_jsEgAoaJT67v6wLbXu-vLrc2d6sKJjkplSgWuB-VvPGTG0SDHZ_tg1lIlKnjcE8aYokzLwd8kRqgT70ExQF471pLKdgp6tt8IFmauuOCap9lrsYQfo0BpBvGFgozK6IGczGGJJo0XzCJa658rggmxrN3qmWEndVjjuU0hgdvqiL4WgMqAiM1-vi1SnW4dPhKR6JXTcI6F3NZPV0lGDZujLHL3gMCkea15-41W48rlC_KQ-FGqA9ORTMVZy',
              'https://lh3.googleusercontent.com/aida-public/AB6AXuBlTlR-2p8s0nM3uRXNe6zFzmnnfSBScA28w3Xskzrs9XYPMvZ2HqKqhLjRnB0txp8Lv73B7U2Sfy1w1CEwH77rcMLP-l2zum5Qg1ks6xhut8Hk8clrVglyXRuiQ1ZZna55S6BtSgHGwaqBK9b4wp-oKe9YxVtKz9M53zLAVdX2f_chGcl_iCIHET_sNPLPBf7GeZA4zgZK22H7SolhTUZl_yqJVwtwVa9xyvZYcj-sxp3XfipK0Fhj7rDgaSo_sdQe6xPg287doUOf',
              'https://lh3.googleusercontent.com/aida-public/AB6AXuB5YxzYD-pDJtQDXhQpGdUYoQcli6isDhrjf12_srsE2UJZ75pR8uZNTNrqIveHIuTnBHDnOtYUgAxyH_7ygk5zt83kmUD7V-W5wmNb4n-tbi2H4z319QGD2nXNWrLYP3viYEwJX33DAnEB0yw-0QJJjcCsgEg5ZbqFnF3Pi5JSTQBhuCANr4BnAyaCZ3v4uajtTo49yusLZsl0hjZmFqfSEJKqBc87GMBCBjnJd2FQCeec3PSfKl4jnDpD8nnfXsH8Nb2NcIJWLjan',
            ],
            extraCount: 2,
          ),
          SizedBox(height: 24),
          Text('Resumen de balances',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          SizedBox(height: 8),
          BalanceTile(name: 'Sofía', amount: -25),
          BalanceTile(name: 'Carlos', amount: -15),
          BalanceTile(name: 'Javier', amount: 40),
          SizedBox(height: 80),
        ],
      ),
      bottomSheet: Padding(
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
      bottomNavigationBar: const AppBottomNavigation(currentIndex: 0),
    );
  }
}
