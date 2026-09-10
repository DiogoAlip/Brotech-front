import '../domain/models/agronomist_profile.dart';

class ProfileRepository {
  AgronomistProfile getProfile() {
    return const AgronomistProfile(
      name: 'Elena Rostova',
      title: 'Agrónoma Principal y Gestora de Finca',
      farmName: 'Finca El Roble',
      zone: 'Zone 9B',
      hectares: 140.0,
      status: 'Activo',
      labId: 'Lab ID #BRO-8841',
      activePlots: 4,
      registeredLots: 12,
      averageGermination: 98.4,
      probesOnline: '18/18',
    );
  }
}
