import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_colors.dart';
import '../controllers/farm_controller.dart';
import '../widgets/wizard/wizard_crop_step.dart';
import '../widgets/wizard/wizard_date_step.dart';
import '../widgets/wizard/wizard_soil_step.dart';

class FarmWizardView extends ConsumerStatefulWidget {
  const FarmWizardView({super.key});

  @override
  ConsumerState<FarmWizardView> createState() => _FarmWizardViewState();
}

class _FarmWizardViewState extends ConsumerState<FarmWizardView> {
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    final initialStep = ref.read(farmControllerProvider).currentWizardStep;
    _pageController = PageController(initialPage: initialStep);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _nextStep() {
    final state = ref.read(farmControllerProvider);
    final controller = ref.read(farmControllerProvider.notifier);
    
    if (state.currentWizardStep < 2) {
      final nextStep = state.currentWizardStep + 1;
      controller.setWizardStep(nextStep);
      _pageController.animateToPage(
        nextStep,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      // Finish wizard and go to reward screen (step 3)
      controller.setWizardStep(3);
    }
  }

  void _prevStep() {
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
    
    // Ensure page controller is in sync if state changed externally
    if (_pageController.hasClients && _pageController.page?.round() != state.currentWizardStep && state.currentWizardStep < 3) {
      _pageController.animateToPage(
        state.currentWizardStep,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }

    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: state.currentWizardStep > 0
            ? IconButton(
                icon: const Icon(Icons.arrow_back, color: AppColors.onSurface),
                onPressed: _prevStep,
              )
            : null,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(3, (index) {
            final isActive = index <= state.currentWizardStep;
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 4),
              height: 8,
              width: 32,
              decoration: BoxDecoration(
                color: isActive ? AppColors.primary : AppColors.surfaceContainerHigh,
                borderRadius: BorderRadius.circular(4),
              ),
            );
          }),
        ),
        centerTitle: true,
      ),
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(), // Disable swipe, force buttons
        children: [
          WizardCropStep(onNext: _nextStep),
          WizardDateStep(onNext: _nextStep),
          WizardSoilStep(onNext: _nextStep),
        ],
      ),
    );
  }
}
