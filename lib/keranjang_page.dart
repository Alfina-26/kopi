import 'package:flutter/material.dart';
import 'data/keranjang_data.dart';
import 'model/produk.dart';

class KeranjangPage extends StatelessWidget {
  const KeranjangPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Keranjang Saya"),
        backgroundColor: Colors.brown,
      ),
      body: keranjangGlobal.isEmpty
          ? const Center(child: Text("Keranjang kosong ☕"))
          : ListView.builder(
              itemCount: keranjangGlobal.length,
              itemBuilder: (context, index) {
                final item = keranjangGlobal[index];
                return ListTile(
                  leading: Icon(item.icon, color: Colors.brown),
                  title: Text(item.name),
                  subtitle: Text(item.desc),
                  trailing: Text(item.price),
                );
              },
            ),
    );
  }
}
