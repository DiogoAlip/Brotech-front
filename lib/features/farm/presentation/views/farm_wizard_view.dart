import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../controllers/farm_controller.dart';
import '../widgets/wizard/wizard_crop_step.dart';
import '../widgets/wizard/wizard_date_step.dart';
import '../widgets/wizard/wizard_soil_step.dart';
import '../widgets/wizard/wizard_size_step.dart';

class FarmWizardView extends ConsumerStatefulWidget {
  const FarmWizardView({super.key});

  @override
  ConsumerState<FarmWizardView> createState() => _FarmWizardViewState();
}

class _FarmWizardViewState extends ConsumerState<FarmWizardView> {
  final PageController _pageController = PageController();

  void _nextStep() {
    final state = ref.read(farmControllerProvider);
    final controller = ref.read(farmControllerProvider.notifier);

    if (state.currentWizardStep < 3) {
      final nextStep = state.currentWizardStep + 1;
      controller.setWizardStep(nextStep);
      _pageController.animateToPage(
        nextStep,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      controller.completeRegistration();
      // Despues de completar, seteamos al currentWizardStep 4 para ver la recompensa
      controller.setWizardStep(4);
    }
  }

  void _previousStep() {
    final state = ref.read(farmControllerProvider);
    final controller = ref.read(farmControllerProvider.notifier);

    if (state.currentWizardStep > 0) {
      final prevStep = state.currentWizardStep - 1;
      controller.setWizardStep(prevStep);
      _pageController.animateToPage(
        prevStep,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(farmControllerProvider);

    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: state.currentWizardStep > 0
            ? IconButton(
                icon: const Icon(Icons.arrow_back, color: AppColors.onSurface),
                onPressed: _previousStep,
              )
            : null,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(4, (index) {
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 4),
              width: 24,
              height: 4,
              decoration: BoxDecoration(
                color: index <= state.currentWizardStep
                    ? AppColors.primary
                    : AppColors.surfaceContainerHigh,
                borderRadius: BorderRadius.circular(2),
              ),
            );
          }),
        ),
        centerTitle: true,
      ),
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(), // Desactiva swipe manual
        children: [
          WizardCropStep(onNext: _nextStep),
          WizardSizeStep(onNext: _nextStep),
          WizardDateStep(onNext: _nextStep),
          WizardSoilStep(onNext: _nextStep),
        ],
      ),
    );
  }
}
