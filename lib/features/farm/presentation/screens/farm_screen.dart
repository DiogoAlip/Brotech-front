import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../controllers/farm_controller.dart';
import '../views/farm_wizard_view.dart';
import '../views/farm_reward_view.dart';
import '../views/farm_dashboard_view.dart';

class FarmScreen extends ConsumerWidget {
  const FarmScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(farmControllerProvider);

    if (state.hasRegisteredCrop) {
      return const FarmDashboardView();
    }

    if (state.currentWizardStep == 3) {
      return const FarmRewardView();
    }

    return const FarmWizardView();
  }
}
