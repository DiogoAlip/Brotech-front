import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/models/especialista.dart';
import '../../data/directorio_repository.dart';

final directorioControllerProvider = AsyncNotifierProvider<DirectorioController, List<Especialista>>(() {
  return DirectorioController();
});

class DirectorioController extends AsyncNotifier<List<Especialista>> {
  late DirectorioRepository _repository;

  @override
  Future<List<Especialista>> build() async {
    _repository = ref.watch(directorioRepositoryProvider);
    return _fetchDirectorio();
  }

  Future<List<Especialista>> _fetchDirectorio() async {
    return await _repository.getEspecialistas();
  }

  Future<void> reload() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => _fetchDirectorio());
  }

  // Future additions: filter by specialty or crop
  void filterBy(String query) {
    // Implement filter logic here when search UI is added
  }
}
