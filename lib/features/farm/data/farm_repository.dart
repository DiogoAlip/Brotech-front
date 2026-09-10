import '../domain/models/parcel.dart';

class FarmRepository {
  List<Parcel> getInitialParcels() {
    return const [
      Parcel(
        id: '1',
        name: 'Lote 1: Valle Norte',
        hectares: 45.0,
        sowingMethod: 'direct_precision',
        seedVariety: 'San Marzano Tomato Lot #SM-2025',
        germinationRate: 98.4,
        targetPh: '6.2 - 6.8',
        density: '28k/Ha',
        status: 'Germinando',
        lotCode: 'SEC-2025-01',
        soilTemp: 19.2,
      ),
      Parcel(
        id: '2',
        name: 'Lote 2: Cresta Sector B',
        hectares: 60.0,
        sowingMethod: 'notill',
        seedVariety: 'Maíz Dulce Híbrido F1 Golden Queen',
        germinationRate: 97.5,
        targetPh: '6.0 - 7.0',
        density: '65k/Ha',
        status: 'Vegetativo',
        lotCode: 'SEC-2025-02',
        soilTemp: 21.0,
      ),
      Parcel(
        id: '3',
        name: 'Lote 3: Terrazas del Sur',
        hectares: 35.0,
        sowingMethod: 'broadcasting',
        seedVariety: 'Acondicionamiento con Cultivo de Cobertura de Nitrógeno',
        germinationRate: 95.0,
        targetPh: '6.5 - 7.2',
        density: '30k/Ha',
        status: 'En barbecho / Listo',
        lotCode: 'SEC-2025-03',
        soilTemp: 18.0,
      ),
    ];
  }
}
