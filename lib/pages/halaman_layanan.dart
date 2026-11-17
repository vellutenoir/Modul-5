import 'package:flutter/material.dart';
import '../models/layanan.dart';
import '../widgets/kartu_layanan.dart';

class HalamanLayanan extends StatelessWidget {
  const HalamanLayanan({super.key});

  @override
  Widget build(BuildContext context) {
    const daftarBidang = ['Perizinan', 'Kesehatan', 'Transportasi'];

    return DefaultTabController(
      length: daftarBidang.length,
      child: Column(
        children: [
          Material(
            color: Theme.of(context).colorScheme.surface,
            child: const TabBar(
              tabs: [
                Tab(
                  icon: Icon(Icons.assignment_turned_in_outlined),
                  text: 'Perizinan',
                ),
                Tab(
                  icon: Icon(Icons.local_hospital_outlined),
                  text: 'Kesehatan',
                ),
                Tab(
                  icon: Icon(Icons.directions_bus_outlined),
                  text: 'Transportasi',
                ),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              children: daftarBidang.map((bidang) {
                final layananPerBidang = Layanan.daftarLayanan
                    .where((item) => item.bidang == bidang)
                    .toList();

                return ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemCount: layananPerBidang.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 10),
                  itemBuilder: (context, index) {
                    return KartuLayanan(layanan: layananPerBidang[index]);
                  },
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
