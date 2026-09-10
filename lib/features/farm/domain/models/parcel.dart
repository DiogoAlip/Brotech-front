class Parcel {
  final String id;
  final String name;
  final double hectares;
  final String sowingMethod;
  final String seedVariety;
  final double germinationRate;
  final String targetPh;
  final String density;
  final String status;
  final String lotCode;
  final double? soilTemp;

  const Parcel({
    required this.id,
    required this.name,
    required this.hectares,
    required this.sowingMethod,
    required this.seedVariety,
    required this.germinationRate,
    required this.targetPh,
    required this.density,
    required this.status,
    required this.lotCode,
    this.soilTemp,
  });

  double get acres => hectares * 2.47105;

  Parcel copyWith({
    String? id,
    String? name,
    double? hectares,
    String? sowingMethod,
    String? seedVariety,
    double? germinationRate,
    String? targetPh,
    String? density,
    String? status,
    String? lotCode,
    double? soilTemp,
  }) {
    return Parcel(
      id: id ?? this.id,
      name: name ?? this.name,
      hectares: hectares ?? this.hectares,
      sowingMethod: sowingMethod ?? this.sowingMethod,
      seedVariety: seedVariety ?? this.seedVariety,
      germinationRate: germinationRate ?? this.germinationRate,
      targetPh: targetPh ?? this.targetPh,
      density: density ?? this.density,
      status: status ?? this.status,
      lotCode: lotCode ?? this.lotCode,
      soilTemp: soilTemp ?? this.soilTemp,
    );
  }
}
