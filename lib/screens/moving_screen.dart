import 'package:flutter/material.dart';

class MovingScreen extends StatelessWidget {
  const MovingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Déménagement et Transport de Marchandises'),
        backgroundColor: const Color(0xFF00695C),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Nos Services',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF00695C),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Nous offrons des services de déménagement et de transport de marchandises pour répondre à tous vos besoins. Que ce soit pour un déménagement local ou international, nous avons les ressources nécessaires pour garantir un service de qualité.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView(
                children: [
                  _buildServiceItem(
                    icon: Icons.local_shipping,
                    title: 'Transport sécurisé',
                    description: 'Nous assurons un transport sécurisé de vos marchandises.',
                  ),
                  _buildServiceItem(
                    icon: Icons.inventory,
                    title: 'Stockage temporaire',
                    description: 'Service de stockage temporaire pour vos biens.',
                  ),
                  _buildServiceItem(
                    icon: Icons.support_agent,
                    title: 'Support client 24/7',
                    description: 'Assistance clientèle disponible 24/7 pour tous vos besoins.',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildServiceItem({required IconData icon, required String title, required String description}) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        leading: Icon(icon, size: 40, color: const Color(0xFF00695C)),
        title: Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(description),
      ),
    );
  }
}
