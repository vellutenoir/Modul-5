import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../app_routes.dart';
import '../cubit/pengajuan_cubit.dart';
import 'halaman_beranda.dart';
import 'halaman_layanan.dart';
import 'halaman_warga.dart';

class KerangkaNavigasi extends StatefulWidget {
  const KerangkaNavigasi({super.key});

  @override
  State<KerangkaNavigasi> createState() => _KerangkaNavigasiState();
}

class _KerangkaNavigasiState extends State<KerangkaNavigasi> {
  int _selectedIndex = 0;

  static const List<String> _judulHalaman = [
    'Nusantara Cerdas - Beranda',
    'Nusantara Cerdas - Layanan',
    'Nusantara Cerdas - Warga',
  ];

  void _ubahTab(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _ikonWargaDenganBadge({required bool terpilih}) {
    final ikonDasar = Icon(terpilih ? Icons.person : Icons.person_outline);
    return BlocSelector<PengajuanCubit, List<ItemPengajuan>, int>(
      selector: (daftar) => daftar.length,
      builder: (context, totalPengajuan) {
        return Badge(
          isLabelVisible: totalPengajuan > 0,
          label: Text('$totalPengajuan'),
          child: ikonDasar,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final halaman = [
      HalamanBeranda(onPindahTab: _ubahTab),
      const HalamanLayanan(),
      const HalamanWarga(),
    ];

    final lebarLayar = MediaQuery.of(context).size.width;
    final isLayarLebar = lebarLayar >= 640;

    return Scaffold(
      appBar: AppBar(
        title: Text(_judulHalaman[_selectedIndex]),
      ),
      drawer: NavigationDrawer(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (idx) {
          Navigator.pop(context);
          if (idx < 3) {
            _ubahTab(idx);
          } else if (idx == 3) {
            Navigator.pushNamed(context, AppRoutes.pengaturan);
          } else if (idx == 4) {
            Navigator.pushNamed(context, AppRoutes.tentang);
          }
        },
        children: const [
          Padding(
            padding: EdgeInsets.fromLTRB(28, 16, 16, 10),
            child: Text(
              'Nusantara Cerdas',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          NavigationDrawerDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: Text('Beranda'),
          ),
          NavigationDrawerDestination(
            icon: Icon(Icons.miscellaneous_services_outlined),
            selectedIcon: Icon(Icons.miscellaneous_services),
            label: Text('Layanan'),
          ),
          NavigationDrawerDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: Text('Warga'),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 28, vertical: 8),
            child: Divider(),
          ),
          NavigationDrawerDestination(
            icon: Icon(Icons.settings_outlined),
            label: Text('Pengaturan'),
          ),
          NavigationDrawerDestination(
            icon: Icon(Icons.info_outline),
            label: Text('Tentang Aplikasi'),
          ),
        ],
      ),
      body: Row(
        children: [
          if (isLayarLebar) ...[
            NavigationRail(
              selectedIndex: _selectedIndex,
              onDestinationSelected: _ubahTab,
              labelType: NavigationRailLabelType.all,
              destinations: [
                const NavigationRailDestination(
                  icon: Icon(Icons.home_outlined),
                  selectedIcon: Icon(Icons.home),
                  label: Text('Beranda'),
                ),
                const NavigationRailDestination(
                  icon: Icon(Icons.miscellaneous_services_outlined),
                  selectedIcon: Icon(Icons.miscellaneous_services),
                  label: Text('Layanan'),
                ),
                NavigationRailDestination(
                  icon: _ikonWargaDenganBadge(terpilih: false),
                  selectedIcon: _ikonWargaDenganBadge(terpilih: true),
                  label: const Text('Warga'),
                ),
              ],
            ),
            const VerticalDivider(thickness: 1, width: 1),
          ],
          Expanded(
            child: IndexedStack(
              index: _selectedIndex,
              children: halaman,
            ),
          ),
        ],
      ),
      bottomNavigationBar: isLayarLebar
          ? null
          : NavigationBar(
              selectedIndex: _selectedIndex,
              onDestinationSelected: _ubahTab,
              destinations: [
                const NavigationDestination(
                  icon: Icon(Icons.home_outlined),
                  selectedIcon: Icon(Icons.home),
                  label: 'Beranda',
                ),
                const NavigationDestination(
                  icon: Icon(Icons.miscellaneous_services_outlined),
                  selectedIcon: Icon(Icons.miscellaneous_services),
                  label: 'Layanan',
                ),
                NavigationDestination(
                  icon: _ikonWargaDenganBadge(terpilih: false),
                  selectedIcon: _ikonWargaDenganBadge(terpilih: true),
                  label: 'Warga',
                ),
              ],
            ),
    );
  }
}
