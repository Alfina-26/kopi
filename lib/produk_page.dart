import 'package:flutter/material.dart';
import '/model/produk.dart';
import '/model/minumanspesial.dart';
import '/model/user.dart';
import '/order_page.dart';
import 'data/keranjang_data.dart';
import 'package:badges/badges.dart' as badges;
import 'package:provider/provider.dart';
import 'providers/cart_provider.dart';


class ProdukPage extends StatefulWidget {
  const ProdukPage({super.key});

  @override
  State<ProdukPage> createState() => _ProdukPageState();
}

class _ProdukPageState extends State<ProdukPage> {
  // Contoh user/customer
  final Customer customer = Customer("pina", "pina29@email.com", "Jl. Mawar No. 1");
  


  // List produk dan minuman spesial
  final List<Produk> menuList = [
    Produk("Espresso", "Kopi hitam pekat khas Italia.", "Rp 18.000", Icons.coffee),
    Produk("Latte", "Espresso dengan banyak susu.", "Rp 23.000", Icons.coffee_outlined),
    Produk("Americano", "Espresso dengan air panas.", "Rp 19.000", Icons.coffee_rounded),
    Produk("Cappuccino", "Espresso dengan susu dan foam.", "Rp 22.000", Icons.local_cafe),
    Produk("Piccolo", "Espresso dengan susu steamed dalam gelas kecil.", "Rp 20.000", Icons.coffee),
    Produk("Ristretto", "Espresso dengan ekstraksi singkat, rasa lebih kuat.", "Rp 19.000", Icons.coffee),
    Produk("Irish Coffee", "Kopi dengan whiskey dan krim.", "Rp 35.000", Icons.local_bar),
    Produk("Kopi Tubruk", "Kopi khas Indonesia dengan gula.", "Rp 15.000", Icons.coffee),
    Produk("Kopi Vietnam Drip", "Kopi robusta dengan susu kental manis.", "Rp 22.000", Icons.coffee),
    Produk("Kopi Arabika Aceh Gayo", "Kopi arabika khas Aceh, aroma kuat.", "Rp 24.000", Icons.coffee),
    Produk("Kopi Robusta Lampung", "Kopi robusta khas Lampung, rasa bold.", "Rp 20.000", Icons.coffee),
    Produk("Kopi Susu Jahe", "Kopi susu dengan jahe hangat.", "Rp 21.000", Icons.local_drink),
    Produk("Kopi Pandan", "Kopi dengan aroma pandan.", "Rp 22.000", Icons.local_cafe),
    Produk("Kopi Aren Latte", "Latte dengan gula aren.", "Rp 23.000", Icons.coffee),
    Produk("Kopi Susu Regal", "Kopi susu dengan biskuit regal.", "Rp 25.000", Icons.coffee),
    Produk("Kopi Susu Alpukat", "Kopi susu dengan alpukat segar.", "Rp 27.000", Icons.coffee),
    Produk("Kopi Susu Coklat", "Kopi susu dengan coklat.", "Rp 24.000", Icons.coffee),
    Produk("Kopi Susu Kelapa", "Kopi susu dengan kelapa muda.", "Rp 26.000", Icons.coffee),
    MinumanSpesial("Kopi Luwak", "Kopi eksklusif dari luwak.", "Rp 80.000", Icons.star, true),
    MinumanSpesial("Signature Cherry Latte", "Latte dengan sirup cherry khas.", "Rp 30.000", Icons.local_cafe, true),
    MinumanSpesial("Signature Kopi Nusantara", "Blend kopi terbaik dari seluruh Indonesia.", "Rp 35.000", Icons.coffee, true),
  ];

  void _showDetail(BuildContext context, Produk menu) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        title: Row(
          children: [
            Icon(menu.icon, color: Colors.brown, size: 32),
            const SizedBox(width: 10),
            Text(menu.name, style: const TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(menu.desc, style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 12),
            Text(
              "Harga: ${menu.price}",
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.brown,
                fontSize: 18,
              ),
            ),
            if (menu is MinumanSpesial && menu.isSignature)
              const Padding(
                padding: EdgeInsets.only(top: 8.0),
                child: Text(
                  "Signature Menu!",
                  style: TextStyle(
                    color: Colors.redAccent,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
          ],
        ),
        actions: [
          TextButton(
            child: const Text("Tutup"),
            onPressed: () => Navigator.pop(context),
          ),
          ElevatedButton(
            onPressed: () {
              final cartProvider = Provider.of<CartProvider>(context, listen: false);
              cartProvider.addToCart(menu);
  
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("${menu.name} ditambahkan ke keranjang!")),
  );
},
  child: const Text('Tambah ke Keranjang'),
)

        ],
      ),
    );
  }

  void _showKeranjang(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Keranjang Belanja"),
        content: SizedBox(
          width: double.maxFinite,
          child: keranjangGlobal.isEmpty

              ? const Text("Keranjang kosong.")
              : ListView(
                  shrinkWrap: true,
                  children: keranjangGlobal.map((p) => ListTile(
                    title: Text(p.name),
                    subtitle: Text(p.desc),
                    trailing: Text(p.price),
                  )).toList(),
                ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Tutup"),
          ),
        ],
      ),
    );
  }

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
              title: Text(menu.name, style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text(menu.desc),
              trailing: Text(menu.price, style: const TextStyle(color: Colors.brown, fontWeight: FontWeight.bold)),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => OrderPage(customer: customer, produk: menu),
                  ),
                );
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.brown,
        icon: const Icon(Icons.shopping_cart),
        label: const Text("Keranjang"),
        onPressed: () => _showKeranjang(context),
      ),
    );
  }
}
