import '../domain/models/seed_product.dart';

class ShopRepository {
  List<SeedProduct> getProducts() {
    return const [
      SeedProduct(
        id: '1',
        name: 'San Marzano Lampadina',
        scientificName: 'Solanum lycopersicum • Certified Non-GMO',
        category: 'Semillas Certificadas',
        price: 14.50,
        originalPrice: 17.00,
        lotCode: 'Lot #SM-2025',
        germinationRate: 98.2,
        treatment: 'Biológico Sin Químicos',
        purity: '99.8% Pureza',
        discountLabel: '15% DTO',
        isOrganic: true,
      ),
      SeedProduct(
        id: '2',
        name: 'Maíz Dulce Híbrido F1 Golden Queen',
        scientificName: 'Zea mays var. saccharata • Alta Pureza',
        category: 'Semillas Certificadas',
        price: 22.00,
        originalPrice: 25.00,
        lotCode: 'Lot #GQ-2025-F1',
        germinationRate: 97.5,
        treatment: 'Inoculado Micorrizas',
        purity: '99.5% Pureza',
        discountLabel: '10% DTO',
        isOrganic: true,
      ),
      SeedProduct(
        id: '3',
        name: 'Portainjerto de Aguacate Hass Enano',
        scientificName: 'Persea americana • Clonal Certificado',
        category: 'Semillas Certificadas',
        price: 34.00,
        originalPrice: 38.00,
        lotCode: 'Lot #AV-HASS-09',
        germinationRate: 95.8,
        treatment: 'Resistente a Phytophthora',
        purity: '100% Clonal',
        isOrganic: false,
      ),
      SeedProduct(
        id: '4',
        name: 'Trigo de Invierno Certificado',
        scientificName: 'Triticum aestivum • Grano Dorado',
        category: 'Semillas Certificadas',
        price: 18.90,
        originalPrice: 21.00,
        lotCode: 'Lot #WH-778-ITA',
        germinationRate: 99.1,
        treatment: 'Semilla Pura Seleccionada',
        purity: '99.9% Pureza',
        isOrganic: true,
      ),
    ];
  }
}
