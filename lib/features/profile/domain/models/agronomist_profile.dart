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
}
