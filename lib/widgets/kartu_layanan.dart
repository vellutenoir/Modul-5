import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../app_routes.dart';
import '../cubit/favorit_cubit.dart';
import '../models/layanan.dart';

class KartuLayanan extends StatelessWidget {
  const KartuLayanan({
    super.key,
    required this.layanan,
  });

  final Layanan layanan;

  IconData _ikonBidang(String bidang) {
    switch (bidang) {
      case 'Perizinan':
        return Icons.assignment_turned_in_outlined;
      case 'Kesehatan':
        return Icons.local_hospital_outlined;
      case 'Transportasi':
        return Icons.directions_bus_outlined;
      default:
        return Icons.public;
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: BorderSide(color: colorScheme.outlineVariant),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: () async {
          final hasil = await Navigator.pushNamed(
            context,
            AppRoutes.rincianLayanan,
            arguments: layanan,
          );
          if (hasil is String && context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(hasil)),
            );
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                backgroundColor: colorScheme.primaryContainer,
                foregroundColor: colorScheme.onPrimaryContainer,
                child: Icon(_ikonBidang(layanan.bidang)),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      layanan.nama,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      layanan.deskripsi,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: colorScheme.onSurfaceVariant,
                          ),
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      children: [
                        Chip(
                          label: Text(layanan.bidang),
                          visualDensity: VisualDensity.compact,
                          padding: EdgeInsets.zero,
                        ),
                        Chip(
                          avatar: const Icon(Icons.schedule, size: 16),
                          label: Text(layanan.estimasiWaktu),
                          visualDensity: VisualDensity.compact,
                          padding: EdgeInsets.zero,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              BlocSelector<FavoritCubit, Set<String>, bool>(
                selector: (favoritSet) => favoritSet.contains(layanan.nama),
                builder: (context, isFavorit) {
                  return IconButton(
                    tooltip: isFavorit
                        ? 'Hapus dari Favorit'
                        : 'Tandai sebagai Favorit',
                    onPressed: () {
                      context.read<FavoritCubit>().toggleFavorit(layanan.nama);
                    },
                    icon: Icon(
                      isFavorit ? Icons.star_rounded : Icons.star_outline_rounded,
                      color: isFavorit ? Colors.amber.shade700 : colorScheme.outline,
                      size: 28,
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
