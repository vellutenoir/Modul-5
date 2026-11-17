import 'package:flutter_bloc/flutter_bloc.dart';

class FavoritCubit extends Cubit<Set<String>> {
  FavoritCubit() : super(<String>{});

  void tandai(String namaLayanan) {
    final salinan = Set<String>.from(state)..add(namaLayanan);
    emit(salinan);
  }

  void batalTandai(String namaLayanan) {
    final salinan = Set<String>.from(state)..remove(namaLayanan);
    emit(salinan);
  }

  void toggleFavorit(String namaLayanan) {
    if (state.contains(namaLayanan)) {
      batalTandai(namaLayanan);
    } else {
      tandai(namaLayanan);
    }
  }
}
