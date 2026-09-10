import 'package:flutter_riverpod/flutter_riverpod.dart';

/// State provider to track and toggle Dark Mode across the application.
final isDarkModeProvider = StateProvider<bool>((ref) => false);
