import 'package:flutter/material.dart';
import '../model/produk.dart';

class CartProvider with ChangeNotifier {
  final List<Produk> _items = [];

  List<Produk> get items => _items;

  // Tambah produk ke keranjang
  void addToCart(Produk produk) {
    _items.add(produk);
    notifyListeners();
  }

  // Hapus produk dari keranjang
  void removeFromCart(Produk produk) {
    _items.remove(produk);
    notifyListeners();
  }

  // Hitung total harga semua produk di keranjang
  double get totalHarga {
    double total = 0;
    for (var item in _items) {
      total += double.tryParse(
            item.price.replaceAll(RegExp(r'[^0-9]'), ''),
          ) ??
          0;
    }
    return total;
  }

  // Kosongkan keranjang
  void clearCart() {
    _items.clear();
    notifyListeners();
  }
}
