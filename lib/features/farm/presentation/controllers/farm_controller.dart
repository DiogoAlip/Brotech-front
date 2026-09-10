import 'package:flutter_riverpod/flutter_riverpod.dart';

class FarmState {
  final bool hasRegisteredCrop;
  final int currentWizardStep;
  final String? selectedCrop;
  final DateTime? selectedDate;
  final String? selectedSoilType;
  final bool isSaving;

  const FarmState({
    this.hasRegisteredCrop = false,
    this.currentWizardStep = 0,
    this.selectedCrop,
    this.selectedDate,
    this.selectedSoilType,
    this.isSaving = false,
  });

  FarmState copyWith({
    bool? hasRegisteredCrop,
    int? currentWizardStep,
    String? selectedCrop,
    DateTime? selectedDate,
    String? selectedSoilType,
    bool? isSaving,
  }) {
    return FarmState(
      hasRegisteredCrop: hasRegisteredCrop ?? this.hasRegisteredCrop,
      currentWizardStep: currentWizardStep ?? this.currentWizardStep,
      selectedCrop: selectedCrop ?? this.selectedCrop,
      selectedDate: selectedDate ?? this.selectedDate,
      selectedSoilType: selectedSoilType ?? this.selectedSoilType,
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

  void completeRegistration() {
    state = state.copyWith(
      hasRegisteredCrop: true,
      currentWizardStep: 0,
    );
  }

  void resetFlow() {
    state = const FarmState();
  }
}

final farmControllerProvider =
    StateNotifierProvider<FarmController, FarmState>((ref) {
  return FarmController();
});

