import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:provider/provider.dart';
import '../model/produk.dart';
import '../model/minumanspesial.dart';
import '../model/user.dart';
import '../providers/cart_provider.dart';
import 'order_page.dart';

class ProdukPage extends StatefulWidget {
  const ProdukPage({super.key});

  @override
  State<ProdukPage> createState() => _ProdukPageState();
}

class _ProdukPageState extends State<ProdukPage> {
  final Customer customer =
      Customer("Pina", "pina29@email.com", "Jl. Mawar No. 1");

  final List<Produk> menuList = [
    // ☕ KOPI KLASIK
    Produk("Espresso", "Kopi hitam pekat khas Italia.", "Rp 18.000", Icons.coffee),
    Produk("Americano", "Espresso dengan air panas.", "Rp 19.000", Icons.coffee_rounded),
    Produk("Latte", "Espresso dengan susu creamy dan foam tipis.", "Rp 23.000", Icons.coffee_outlined),
    Produk("Cappuccino", "Espresso, susu, dan foam tebal di atasnya.", "Rp 22.000", Icons.local_cafe),
    Produk("Macchiato", "Espresso dengan sedikit susu steamed.", "Rp 21.000", Icons.coffee),
    Produk("Mocha", "Campuran espresso, cokelat, dan susu hangat.", "Rp 25.000", Icons.coffee),
    Produk("Piccolo", "Espresso dengan susu steamed dalam gelas kecil.", "Rp 20.000", Icons.coffee),
    Produk("Flat White", "Espresso dengan susu lembut tanpa foam.", "Rp 24.000", Icons.local_cafe),
    Produk("Ristretto", "Versi espresso yang lebih pekat dan kuat.", "Rp 20.000", Icons.local_drink),

    // 🧊 KOPI DINGIN
    Produk("Iced Americano", "Espresso dengan air dingin dan es batu.", "Rp 21.000", Icons.icecream),
    Produk("Iced Latte", "Espresso dengan susu dan es batu segar.", "Rp 24.000", Icons.icecream),
    Produk("Iced Caramel Macchiato", "Espresso, susu, dan sirup karamel.", "Rp 27.000", Icons.local_cafe_outlined),
    Produk("Iced Mocha", "Cokelat, espresso, susu, dan es.", "Rp 28.000", Icons.coffee_rounded),

    // 🍵 NON-KOPI
    Produk("Matcha Latte", "Matcha premium dengan susu steamed.", "Rp 26.000", Icons.local_drink),
    Produk("Red Velvet Latte", "Minuman manis lembut dengan rasa red velvet.", "Rp 25.000", Icons.favorite),
    Produk("Chocolate Latte", "Cokelat panas pekat dan creamy.", "Rp 24.000", Icons.local_cafe),
    Produk("Vanilla Milk", "Susu segar dengan sirup vanila alami.", "Rp 20.000", Icons.local_drink),
    Produk("Honey Lemon Tea", "Teh lemon dengan madu alami.", "Rp 19.000", Icons.emoji_food_beverage),
    Produk("Thai Tea", "Teh Thailand khas dengan susu kental manis.", "Rp 23.000", Icons.local_drink_outlined),

    // 🍰 SNACK & DESSERT (tambahan)
    Produk("Croissant Butter", "Croissant lembut dengan aroma mentega.", "Rp 15.000", Icons.bakery_dining),
    Produk("Chocolate Muffin", "Muffin cokelat lembut dan manis.", "Rp 18.000", Icons.bakery_dining),
    Produk("Cheese Cake", "Kue keju lembut dengan base graham.", "Rp 28.000", Icons.cake),
    Produk("Cinnamon Roll", "Roti manis dengan gula kayu manis.", "Rp 20.000", Icons.bakery_dining_outlined),
    Produk("Tiramisu Slice", "Kue kopi khas Italia, creamy dan lembut.", "Rp 30.000", Icons.cake_outlined),

    // 🌟 MINUMAN SPESIAL CHERRY COFFEE
    MinumanSpesial("Signature Cherry Latte", "Latte dengan sirup cherry khas Cherry Coffee.", "Rp 30.000", Icons.local_cafe, true),
    MinumanSpesial("Kopi Luwak Premium", "Kopi eksklusif dari luwak pilihan terbaik.", "Rp 80.000", Icons.star, true),
    MinumanSpesial("Cherry Cold Brew", "Cold brew dengan sirup cherry segar.", "Rp 35.000", Icons.icecream, true),
    MinumanSpesial("Salted Caramel Cold Brew", "Cold brew dengan krim karamel asin manis.", "Rp 32.000", Icons.local_drink, true),
    MinumanSpesial("Affogato", "Espresso dengan satu scoop es krim vanilla.", "Rp 28.000", Icons.icecream, true),
    MinumanSpesial("Coffee Float", "Kopi dingin dengan es krim vanilla di atasnya.", "Rp 29.000", Icons.icecream, true),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Menu Cherry Coffee"),
        backgroundColor: Colors.brown,
        actions: [
          Consumer<CartProvider>(
            builder: (context, cart, child) {
              return badges.Badge(
                position: badges.BadgePosition.topEnd(top: 2, end: 4),
                badgeContent: Text(
                  cart.items.length.toString(),
                  style: const TextStyle(color: Colors.white, fontSize: 12),
                ),
                showBadge: cart.items.isNotEmpty,
                child: IconButton(
                  icon: const Icon(Icons.shopping_cart),
                  tooltip: "Lihat Keranjang",
                  onPressed: () {
                    Navigator.pushNamed(context, '/cart');
                  },
                ),
              );
            },
          ),
        ],
      ),
      backgroundColor: Colors.brown[50],
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: menuList.length,
        itemBuilder: (context, index) {
          final menu = menuList[index];
          return Card(
            elevation: 4,
            margin: const EdgeInsets.symmetric(vertical: 8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: ListTile(
              leading: Icon(menu.icon, color: Colors.brown, size: 36),
              title: Text(menu.name,
                  style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text(menu.desc),
              trailing: Text(
                menu.price,
                style: const TextStyle(
                    color: Colors.brown, fontWeight: FontWeight.bold),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => OrderPage(produk: menu),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
