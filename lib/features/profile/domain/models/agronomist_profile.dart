class AgronomistProfile {
  final String name;
  final String title;
  final String farmName;
  final String zone;
  final double hectares;
  final String status;
  final String labId;
  final int activePlots;
  final int registeredLots;
  final double averageGermination;
  final String probesOnline;

  const AgronomistProfile({
    required this.name,
    required this.title,
    required this.farmName,
    required this.zone,
    required this.hectares,
    required this.status,
    required this.labId,
    required this.activePlots,
    required this.registeredLots,
    required this.averageGermination,
    required this.probesOnline,
  });

  AgronomistProfile copyWith({
    String? name,
    String? title,
    String? farmName,
    String? zone,
    double? hectares,
    String? status,
    String? labId,
    int? activePlots,
    int? registeredLots,
    double? averageGermination,
    String? probesOnline,
  }) {
    return AgronomistProfile(
      name: name ?? this.name,
      title: title ?? this.title,
      farmName: farmName ?? this.farmName,
      zone: zone ?? this.zone,
      hectares: hectares ?? this.hectares,
      status: status ?? this.status,
      labId: labId ?? this.labId,
      activePlots: activePlots ?? this.activePlots,
      registeredLots: registeredLots ?? this.registeredLots,
      averageGermination: averageGermination ?? this.averageGermination,
      probesOnline: probesOnline ?? this.probesOnline,
    );
  }
}
