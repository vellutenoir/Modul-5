import 'package:flutter/material.dart';

class HalamanPengaturan extends StatefulWidget {
  const HalamanPengaturan({super.key});

  @override
  State<HalamanPengaturan> createState() => _HalamanPengaturanState();
}

class _HalamanPengaturanState extends State<HalamanPengaturan> {
  bool _notifikasiStatus = true;
  bool _modeHematData = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pengaturan Aplikasi')),
      body: ListView(
        children: [
          SwitchListTile(
            secondary: const Icon(Icons.notifications_active_outlined),
            title: const Text('Notifikasi Status Permohonan'),
            subtitle: const Text('Terima pemberitahuan saat berkas diproses dinas'),
            value: _notifikasiStatus,
            onChanged: (val) => setState(() => _notifikasiStatus = val),
          ),
          const Divider(height: 1),
          SwitchListTile(
            secondary: const Icon(Icons.data_saver_on_outlined),
            title: const Text('Mode Hemat Data'),
            subtitle: const Text('Kurangi animasi dan pemuatan gambar beresolusi tinggi'),
            value: _modeHematData,
            onChanged: (val) => setState(() => _modeHematData = val),
          ),
        ],
      ),
    );
  }
}
