import 'package:flutter/foundation.dart';
import '../model/produk.dart';

class CartProvider extends ChangeNotifier {
  final List<Produk> _items = [];

  List<Produk> get items => _items;

  void addToCart(Produk produk) {
    _items.add(produk);
    notifyListeners();
  }

  void removeFromCart(Produk produk) {
    _items.remove(produk);
    notifyListeners();
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
  }

  int get totalHarga {
    int total = 0;
    for (var p in _items) {
      final angka = int.tryParse(p.price.replaceAll(RegExp(r'[^0-9]'), '')) ?? 0;
      total += angka;
    }
    return total;
  }
}
