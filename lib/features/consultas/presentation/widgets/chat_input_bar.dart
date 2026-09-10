import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';

class ChatInputBar extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String> onSend;

  const ChatInputBar({
    super.key,
    required this.controller,
    required this.onSend,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.primary.withValues(alpha: 0.15)),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.1),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          // Attachment / Scan button
          IconButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Adjuntar análisis de suelo o foto de cultivo')),
              );
            },
            icon: const Icon(Icons.add_circle, color: AppColors.primary, size: 24),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(minWidth: 36, minHeight: 36),
          ),
          const SizedBox(width: 4),

          // Message input
          Expanded(
            child: TextField(
              controller: controller,
              style: AppTypography.bodyMd,
              decoration: InputDecoration(
                hintText: 'Pregunta a Brotec o programa labores...',
                hintStyle: AppTypography.bodyMd.copyWith(color: AppColors.outline),
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
                isDense: true,
                filled: false,
              ),
              onSubmitted: (val) {
                onSend(val);
                controller.clear();
              },
            ),
          ),
          const SizedBox(width: 4),

          // Voice mic button
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.mic, color: AppColors.onSurfaceVariant, size: 22),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(minWidth: 36, minHeight: 36),
          ),
          const SizedBox(width: 4),

          // Send button
          Material(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(8),
            child: InkWell(
              borderRadius: BorderRadius.circular(8),
              onTap: () {
                onSend(controller.text);
                controller.clear();
              },
              child: const SizedBox(
                width: 36,
                height: 36,
                child: Icon(Icons.arrow_upward, color: Colors.white, size: 20),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
