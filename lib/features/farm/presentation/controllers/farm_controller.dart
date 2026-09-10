import 'package:flutter_riverpod/flutter_riverpod.dart';

class ParcelModel {
  final String id;
  final String crop;
  final DateTime date;
  final String? soilType;
  final double hectares;

  const ParcelModel({
    required this.id,
    required this.crop,
    required this.date,
    this.soilType,
    required this.hectares,
  });
}

class FarmState {
  final List<ParcelModel> parcels;
  final int currentWizardStep;
  final String? selectedCrop;
  final DateTime? selectedDate;
  final String? selectedSoilType;
  final double? selectedHectares;
  final bool isCreatingNewParcel;
  final bool isSaving;

  const FarmState({
    this.parcels = const [],
    this.currentWizardStep = 0,
    this.selectedCrop,
    this.selectedDate,
    this.selectedSoilType,
    this.selectedHectares,
    this.isCreatingNewParcel = false,
    this.isSaving = false,
  });

  FarmState copyWith({
    List<ParcelModel>? parcels,
    int? currentWizardStep,
    String? selectedCrop,
    DateTime? selectedDate,
    String? selectedSoilType,
    double? selectedHectares,
    bool? isCreatingNewParcel,
    bool? isSaving,
  }) {
    return FarmState(
      parcels: parcels ?? this.parcels,
      currentWizardStep: currentWizardStep ?? this.currentWizardStep,
      selectedCrop: selectedCrop ?? this.selectedCrop,
      selectedDate: selectedDate ?? this.selectedDate,
      selectedSoilType: selectedSoilType ?? this.selectedSoilType,
      selectedHectares: selectedHectares ?? this.selectedHectares,
      isCreatingNewParcel: isCreatingNewParcel ?? this.isCreatingNewParcel,
      isSaving: isSaving ?? this.isSaving,
    );
  }
}

class FarmController extends StateNotifier<FarmState> {
  FarmController() : super(const FarmState());

  void setWizardStep(int step) {
    state = state.copyWith(currentWizardStep: step);
  }

  void selectCrop(String crop) {
    state = state.copyWith(selectedCrop: crop);
  }

  void selectDate(DateTime date) {
    state = state.copyWith(selectedDate: date);
  }

  void selectSoilType(String? soilType) {
    state = state.copyWith(selectedSoilType: soilType);
  }

  void selectHectares(double hectares) {
    state = state.copyWith(selectedHectares: hectares);
  }

  void startNewParcel() {
    state = state.copyWith(
      isCreatingNewParcel: true,
      currentWizardStep: 0,
      selectedCrop: null,
      selectedDate: null,
      selectedSoilType: null,
      selectedHectares: null,
    );
  }

  void completeRegistration() {
    if (state.selectedCrop == null || state.selectedDate == null || state.selectedHectares == null) {
      return;
    }

    final newParcel = ParcelModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      crop: state.selectedCrop!,
      date: state.selectedDate!,
      soilType: state.selectedSoilType,
      hectares: state.selectedHectares!,
    );

    state = state.copyWith(
      parcels: [...state.parcels, newParcel],
      isCreatingNewParcel: false,
      currentWizardStep: 0,
      selectedCrop: null,
      selectedDate: null,
      selectedSoilType: null,
      selectedHectares: null,
    );
  }

  void resetFlow() {
    // Solo borramos el wizard actual, no las parcelas
    state = state.copyWith(
      isCreatingNewParcel: state.parcels.isEmpty,
      currentWizardStep: 0,
      selectedCrop: null,
      selectedDate: null,
      selectedSoilType: null,
      selectedHectares: null,
    );
  }
}

final farmControllerProvider =
    StateNotifierProvider<FarmController, FarmState>((ref) {
  return FarmController();
});

