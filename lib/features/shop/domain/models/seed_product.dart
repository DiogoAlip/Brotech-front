class SeedProduct {
  final String id;
  final String name;
  final String scientificName;
  final String category;
  final double price;
  final double? originalPrice;
  final String lotCode;
  final double germinationRate;
  final String treatment;
  final String purity;
  final String? discountLabel;
  final bool isOrganic;

  const SeedProduct({
    required this.id,
    required this.name,
    required this.scientificName,
    required this.category,
    required this.price,
    this.originalPrice,
    required this.lotCode,
    required this.germinationRate,
    required this.treatment,
    required this.purity,
    this.discountLabel,
    this.isOrganic = true,
  });
}
