import '../domain/models/seed_product.dart';

class ShopRepository {
  List<SeedProduct> getProducts() {
    return const [
      SeedProduct(
        id: '1',
        name: 'Semilla de Maíz Amarillo',
        category: 'Semillas',
        price: 14.50,
        originalPrice: 17.00,
        providerName: 'AgroSemillas Don Pepe',
        isCertifiedProvider: true,
        certificationDetails: 'Certificado por SENASA',
        qualityLabel: 'Alta Germinación',
        discountLabel: 'Oferta Local',
      ),
      SeedProduct(
        id: '2',
        name: 'Semilla de Cacao Fino',
        category: 'Semillas',
        price: 22.00,
        providerName: 'Cooperativa Agraria VRAEM',
        isCertifiedProvider: true,
        certificationDetails: 'Certificación Orgánica',
        qualityLabel: 'Rápido Crecimiento',
      ),
      SeedProduct(
        id: '3',
        name: 'Abono Natural (Compost)',
        category: 'Fertilizantes',
        price: 12.00,
        originalPrice: 15.00,
        providerName: 'Insumos Agrícolas El Sol',
        isCertifiedProvider: false,
        qualityLabel: '100% Orgánico',
        discountLabel: '20% DCTO',
      ),
      SeedProduct(
        id: '4',
        name: 'Semilla de Arroz',
        category: 'Semillas',
        price: 18.90,
        providerName: 'AgroSemillas Don Pepe',
        isCertifiedProvider: true,
        certificationDetails: 'Certificado por SENASA',
        qualityLabel: 'Resistente a Plagas',
      ),
    ];
  }
}
