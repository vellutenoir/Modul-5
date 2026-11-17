import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'app_routes.dart';
import 'cubit/favorit_cubit.dart';
import 'cubit/pengajuan_cubit.dart';
import 'pages/halaman_pengaturan.dart';
import 'pages/halaman_rincian_layanan.dart';
import 'pages/halaman_tentang.dart';
import 'pages/kerangka_navigasi.dart';

void main() {
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<FavoritCubit>(create: (_) => FavoritCubit()),
        BlocProvider<PengajuanCubit>(create: (_) => PengajuanCubit()),
      ],
      child: const NusantaraCerdasApp(),
    ),
  );
}

class NusantaraCerdasApp extends StatelessWidget {
  const NusantaraCerdasApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Nusantara Cerdas - 707012400012',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF0F6B5D)),
        useMaterial3: true,
      ),
      initialRoute: AppRoutes.beranda,
      routes: {
        AppRoutes.beranda: (context) => const KerangkaNavigasi(),
        AppRoutes.rincianLayanan: (context) => const HalamanRincianLayanan(),
        AppRoutes.pengaturan: (context) => const HalamanPengaturan(),
        AppRoutes.tentang: (context) => const HalamanTentang(),
      },
    );
  }
}
