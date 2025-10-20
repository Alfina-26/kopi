import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
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
    Produk("Espresso", "Kopi hitam pekat khas Italia.", "Rp 18.000", Icons.coffee),
    Produk("Americano", "Espresso dengan air panas.", "Rp 19.000", Icons.coffee_rounded),
    Produk("Latte", "Espresso dengan susu creamy dan foam tipis.", "Rp 23.000", Icons.coffee_outlined),
    Produk("Cappuccino", "Espresso, susu, dan foam tebal di atasnya.", "Rp 22.000", Icons.local_cafe),
    Produk("Mocha", "Campuran espresso, cokelat, dan susu hangat.", "Rp 25.000", Icons.coffee),
    Produk("Macchiato", "Espresso dengan sedikit susu steamed.", "Rp 21.000", Icons.local_cafe),
    Produk("Iced Latte", "Espresso dengan susu dan es batu segar.", "Rp 24.000", Icons.icecream),
    Produk("Matcha Latte", "Matcha premium dengan susu steamed.", "Rp 26.000", Icons.local_drink),
    MinumanSpesial("Signature Cherry Latte", "Latte dengan sirup cherry khas Cherry Coffee.", "Rp 30.000", Icons.local_cafe, true),
    MinumanSpesial("Kopi Luwak Premium", "Kopi eksklusif dari luwak pilihan terbaik.", "Rp 80.000", Icons.star, true),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F3EC), // soft coffee cream
      appBar: AppBar(
        backgroundColor: Colors.brown.shade800,
        elevation: 0,
        centerTitle: true,
        title: ShaderMask(
          shaderCallback: (bounds) => const LinearGradient(
            colors: [Color(0xFFD7A86E), Color(0xFFB87333)], // gold to bronze
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ).createShader(bounds),
          child: Text(
            "☕ Menu Cherry Coffee ☕",
            style: GoogleFonts.playfairDisplay(
              fontWeight: FontWeight.bold,
              fontSize: 22,
              color: Colors.white,
              letterSpacing: 1.3,
            ),
          ),
        ),
        actions: [
          Consumer<CartProvider>(
            builder: (context, cart, child) {
              return badges.Badge(
                position: badges.BadgePosition.topEnd(top: 2, end: 3),
                badgeContent: Text(
                  cart.items.length.toString(),
                  style: const TextStyle(color: Colors.white, fontSize: 12),
                ),
                showBadge: cart.items.isNotEmpty,
                badgeStyle: const badges.BadgeStyle(
                  badgeColor: Color(0xFFD2691E), // caramel
                  elevation: 2,
                ),
                child: IconButton(
                  icon: const Icon(
                    Icons.shopping_cart_rounded,
                    size: 28,
                    color: Color(0xFFFFD700), // gold
                  ),
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

      // BODY
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: menuList.length,
        itemBuilder: (context, index) {
          final menu = menuList[index];
          return AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeInOut,
            margin: const EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              gradient: const LinearGradient(
                colors: [
                  Color(0xFFFFF7E5),
                  Color(0xFFEAD7B7),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.brown.withOpacity(0.2),
                  blurRadius: 6,
                  offset: const Offset(2, 3),
                ),
              ],
            ),
            child: InkWell(
              borderRadius: BorderRadius.circular(16),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => OrderPage(produk: menu),
                  ),
                );
              },
              onHover: (hover) {},
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 14),
                child: Row(
                  children: [
                    // ICON MENU
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.brown.shade700.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Icon(
                        menu.icon,
                        color: Colors.brown.shade800,
                        size: 34,
                      ),
                    ),
                    const SizedBox(width: 16),

                    // TEXT MENU
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            menu.name,
                            style: GoogleFonts.poppins(
                              fontSize: 17,
                              fontWeight: FontWeight.w600,
                              color: Colors.brown.shade900,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            menu.desc,
                            style: GoogleFonts.poppins(
                              fontSize: 13.5,
                              color: Colors.brown.shade600,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // HARGA
                    Text(
                      menu.price,
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold,
                        color: Colors.brown.shade800,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
