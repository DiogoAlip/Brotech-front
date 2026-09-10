import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/profile_repository.dart';
import '../../domain/models/agronomist_profile.dart';

class ProfileController extends StateNotifier<AgronomistProfile> {
  final ProfileRepository _repository;

  ProfileController(this._repository) : super(_repository.getProfile());
}

final profileRepositoryProvider = Provider<ProfileRepository>((ref) {
  return ProfileRepository();
});

final profileControllerProvider =
    StateNotifierProvider<ProfileController, AgronomistProfile>((ref) {
  final repo = ref.watch(profileRepositoryProvider);
  return ProfileController(repo);
});
