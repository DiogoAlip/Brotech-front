import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../views/chatbot_view.dart';
import '../views/directorio_view.dart';

class ConsultasScreen extends StatelessWidget {
  const ConsultasScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          Container(
            color: AppColors.surfaceContainerLowest,
            child: TabBar(
              indicatorColor: AppColors.secondary,
              labelColor: AppColors.secondary,
              unselectedLabelColor: AppColors.onSurfaceVariant,
              labelStyle: AppTypography.labelLg.copyWith(fontWeight: FontWeight.w600),
              unselectedLabelStyle: AppTypography.labelLg.copyWith(fontWeight: FontWeight.w500),
              tabs: const [
                Tab(text: 'Asistente Virtual'),
                Tab(text: 'ESPECIALISTAS'),
              ],
            ),
          ),
          const Expanded(
            child: TabBarView(
              children: [
                ChatbotView(),
                DirectorioView(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
