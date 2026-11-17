import 'package:flutter/material.dart';

class HalamanTentang extends StatelessWidget {
  const HalamanTentang({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tentang Nusantara Cerdas')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Card(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: BorderSide(color: Theme.of(context).colorScheme.outlineVariant),
          ),
          child: const Padding(
            padding: EdgeInsets.all(18),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Nusantara Cerdas Mobile',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text(
                  'Aplikasi layanan terpadu warga berbasis Flutter untuk mendukung pilar Smart Governance & Smart Living.',
                ),
                SizedBox(height: 14),
                Text('Pengembang: Vayola Aura Mecca (707012400012)'),
                Text('Kelas: D4SIKC-48-03'),
                Text('State Management: flutter_bloc (Cubit & setState)'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
