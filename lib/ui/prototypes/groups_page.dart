import 'package:flutter/material.dart';

import '../widgets/app_bottom_navigation.dart';

const lightGray = Color(0xFFF5F5F5);
const blueishGray = Color(0xFF7C8B9A);

class GroupsPage extends StatelessWidget {
  const GroupsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final groups = [
      {
        'title': 'Viaje a la playa',
        'members': '3 miembros, 12 gastos',
        'image':
            'https://lh3.googleusercontent.com/aida-public/AB6AXuAwDjdRzRplnUx5pcTvXxQCmJ6A_njh2nBUWzTr8eVWIbW3wVhOzVJUouKTvslPCcLJDC6Gf8lE2Hbwhpuj1xGkjg_iR9mNvYj4o7bUcEXEINWiTF1GMMxyiZvsiHoN8jSzO4EmfSC1M92ZEA4bcNX49HBPO2ZiTdUNEZI9-ugwbp9GpfpFPbLYffKbreRkj0STcnjgQPr7ikQ31ybftWQl3OeCHr-murrimRQ1QjpwbNmxAyWmFOw_CMBvqWugv3ke6J035dV3M5_G',
      },
      {
        'title': 'Cena con amigos',
        'members': '2 miembros, 5 gastos',
        'image':
            'https://lh3.googleusercontent.com/aida-public/AB6AXuBoXwL6o57sQflYZ8hR9ioNd3N4R4qI8FKdI3I9PUwxEGSpuXcqULy3jTInPZvWOEQA-S5VZSAhbG1Yr2AkWinetGWItI1gfV107sNBYrzxQgKmYcQSgNA9KKPjILmEznZtJL1NO2JHW8zGDyrOJmeURB9xjGyAQMrgHsz5JfMXlv7HLk7skjMew9QXnuUPxfQ73zGnB9xY5I4sSJu0JInqbO63B1yARLiL_bqm4aQp_6b1A_1f4JuE-UTIm0KHZLddMZASPVIeCUsk',
      },
      {
        'title': 'Alquiler de casa',
        'members': '4 miembros, 20 gastos',
        'image':
            'https://lh3.googleusercontent.com/aida-public/AB6AXuCFPRUBEYIng5qXViFJzHgDr3vsHFeIamjj3ZWmWhYy5JrKodAi92Kt8zJF4PCxS26NaTTOTdh1Glav2ULCAF4G6Ht2HLBLmRZyoEJS1kja7lvLgO7_wFz28ByZ9Oh1p8hPCgJENIk23N674vp8JXU3NSJyF3hzj3Jrm31lIGYaWyj7UkmuuK5Md1aG7ONjMoDmPx8QfyRhNVa3z-W-Ws64S9cKigDlevnrpCMhM_O84JbTV78FYvv9ld7VS730Gsj3PYO7BuKU4m1V',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Stitch AI'),
        actions: [IconButton(icon: const Icon(Icons.add), onPressed: () {})],
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: groups.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, i) {
          final g = groups[i];
          return ListTile(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
            tileColor: lightGray,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                g['image']!,
                width: 56,
                height: 56,
                fit: BoxFit.cover,
              ),
            ),
            title: Text(
              g['title']!,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(g['members']!),
            trailing: const Icon(Icons.chevron_right, color: blueishGray),
            onTap: () {},
          );
        },
      ),
      bottomNavigationBar: const AppBottomNavigation(currentIndex: 0),
    );
  }
}
