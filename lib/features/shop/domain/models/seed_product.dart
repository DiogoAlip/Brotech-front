class SeedProduct {
  final String id;
  final String name;
  final String category;
  final double price;
  final double? originalPrice;
  final String providerName;
  final bool isCertifiedProvider;
  final String? certificationDetails;
  final String qualityLabel; // Replaces germinationRate and purity for simpler UI
  final String? discountLabel;

  const SeedProduct({
    required this.id,
    required this.name,
    required this.category,
    required this.price,
    this.originalPrice,
    required this.providerName,
    this.isCertifiedProvider = false,
    this.certificationDetails,
    required this.qualityLabel,
    this.discountLabel,
  });
}
