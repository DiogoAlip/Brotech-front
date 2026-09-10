import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/farm_repository.dart';
import '../../domain/models/parcel.dart';

class FarmState {
  final List<Parcel> parcels;
  final double currentHectares;
  final String selectedSowingMethod;
  final String selectedSeedVariety;
  final bool isSaving;
  final String? message;

  const FarmState({
    required this.parcels,
    required this.currentHectares,
    required this.selectedSowingMethod,
    required this.selectedSeedVariety,
    this.isSaving = false,
    this.message,
  });

  double get acres => currentHectares * 2.47105;

  FarmState copyWith({
    List<Parcel>? parcels,
    double? currentHectares,
    String? selectedSowingMethod,
    String? selectedSeedVariety,
    bool? isSaving,
    String? message,
  }) {
    return FarmState(
      parcels: parcels ?? this.parcels,
      currentHectares: currentHectares ?? this.currentHectares,
      selectedSowingMethod: selectedSowingMethod ?? this.selectedSowingMethod,
      selectedSeedVariety: selectedSeedVariety ?? this.selectedSeedVariety,
      isSaving: isSaving ?? this.isSaving,
      message: message,
    );
  }
}

class FarmController extends StateNotifier<FarmState> {
  final FarmRepository _repository;

  FarmController(this._repository)
      : super(
          FarmState(
            parcels: _repository.getInitialParcels(),
            currentHectares: 140.0,
            selectedSowingMethod: 'direct_precision',
            selectedSeedVariety: 'san_marzano',
          ),
        );

  void updateHectares(double hectares) {
    state = state.copyWith(currentHectares: hectares);
  }

  void updateSowingMethod(String method) {
    state = state.copyWith(selectedSowingMethod: method);
  }

  void updateSeedVariety(String variety) {
    state = state.copyWith(selectedSeedVariety: variety);
  }

  Future<void> registerParcel() async {
    state = state.copyWith(isSaving: true);
    await Future.delayed(const Duration(milliseconds: 600));

    final newParcel = Parcel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: 'Lote ${state.parcels.length + 1}: Parcela ${state.selectedSeedVariety}',
      hectares: state.currentHectares,
      sowingMethod: state.selectedSowingMethod,
      seedVariety: state.selectedSeedVariety == 'san_marzano'
          ? 'San Marzano Heirloom Tomato'
          : state.selectedSeedVariety,
      germinationRate: 98.4,
      targetPh: '6.2 - 6.8',
      density: '28k/Ha',
      status: 'Configurada',
      lotCode: 'SEC-2025-0${state.parcels.length + 1}',
      soilTemp: 18.4,
    );

    state = state.copyWith(
      parcels: [newParcel, ...state.parcels],
      isSaving: false,
      message: '¡Configuración de parcela registrada con éxito!',
    );
  }
}

final farmRepositoryProvider = Provider<FarmRepository>((ref) {
  return FarmRepository();
});

final farmControllerProvider =
    StateNotifierProvider<FarmController, FarmState>((ref) {
  final repo = ref.watch(farmRepositoryProvider);
  return FarmController(repo);
});
