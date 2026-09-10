import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/shop_repository.dart';
import '../../domain/models/seed_product.dart';

class ShopState {
  final List<SeedProduct> products;
  final String selectedCategory;
  final String searchQuery;
  final int cartCount;

  const ShopState({
    required this.products,
    required this.selectedCategory,
    this.searchQuery = '',
    this.cartCount = 3,
  });

  List<SeedProduct> get filteredProducts {
    return products.where((p) {
      final matchesCategory = selectedCategory == 'Todos los Productos' || p.category == selectedCategory;
      final matchesQuery = searchQuery.isEmpty ||
          p.name.toLowerCase().contains(searchQuery.toLowerCase()) ||
          p.scientificName.toLowerCase().contains(searchQuery.toLowerCase()) ||
          p.lotCode.toLowerCase().contains(searchQuery.toLowerCase());
      return matchesCategory && matchesQuery;
    }).toList();
  }

  ShopState copyWith({
    List<SeedProduct>? products,
    String? selectedCategory,
    String? searchQuery,
    int? cartCount,
  }) {
    return ShopState(
      products: products ?? this.products,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      searchQuery: searchQuery ?? this.searchQuery,
      cartCount: cartCount ?? this.cartCount,
    );
  }
}

class ShopController extends StateNotifier<ShopState> {
  final ShopRepository _repository;

  ShopController(this._repository)
      : super(
          ShopState(
            products: _repository.getProducts(),
            selectedCategory: 'Todos los Productos',
          ),
        );

  void selectCategory(String category) {
    state = state.copyWith(selectedCategory: category);
  }

  void search(String query) {
    state = state.copyWith(searchQuery: query);
  }

  void addToCart(SeedProduct product) {
    state = state.copyWith(cartCount: state.cartCount + 1);
  }
}

final shopRepositoryProvider = Provider<ShopRepository>((ref) {
  return ShopRepository();
});

final shopControllerProvider =
    StateNotifierProvider<ShopController, ShopState>((ref) {
  final repo = ref.watch(shopRepositoryProvider);
  return ShopController(repo);
});
