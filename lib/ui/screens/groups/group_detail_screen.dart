import "package:flutter/material.dart";

class GroupDetailScreen extends StatelessWidget {
  final String id;
  const GroupDetailScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Grupo $id")),
      body: const Center(child: Text("Detalle de grupo")),
    );
  }
}
