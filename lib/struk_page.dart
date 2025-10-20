import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class StrukPage extends StatelessWidget {
  final double totalBayar;
  final String metode;
  final double nominal;
  final double kembalian;

  const StrukPage({
    super.key,
    required this.totalBayar,
    required this.metode,
    required this.nominal,
    required this.kembalian,
  });

  @override
  Widget build(BuildContext context) {
    final String tanggal =
        DateFormat("d MMMM yyyy, HH:mm").format(DateTime.now());
    final double dialogWidth = MediaQuery.of(context).size.width * 0.85;

    return Center(
      child: Container(
        width: dialogWidth > 360 ? 360 : dialogWidth,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: const Color(0xFFFFE6EB), // pink lembut khas Cherry Coffee
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.brown.withOpacity(0.25),
              blurRadius: 10,
              offset: const Offset(3, 6),
            ),
          ],
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // LOGO
              Image.asset(
                'assets/logo1.png',
                width: 60,
                height: 60,
              ),
              const SizedBox(height: 8),

              // NAMA TOKO
              const Text(
                "Cherry Coffee",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFE91E63),
                ),
              ),
              const Text(
                "Jl. Kenangan No. 26, Bali",
                style: TextStyle(fontSize: 13, color: Colors.black87),
              ),
              const Divider(thickness: 1.2, color: Colors.black54),

              const SizedBox(height: 6),
              const Text(
                "Struk Pembayaran",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFE91E63),
                ),
              ),
              Text(
                tanggal,
                style: const TextStyle(fontSize: 12, color: Colors.black54),
              ),
              const SizedBox(height: 10),

              // DETAIL PRODUK
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Americano", style: TextStyle(fontSize: 15)),
                  Text("Rp ${totalBayar.toStringAsFixed(0)}",
                      style: const TextStyle(fontSize: 15)),
                ],
              ),
              const Divider(thickness: 1, color: Colors.black54),
              const SizedBox(height: 6),

              // TOTAL
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Total",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFE91E63),
                    ),
                  ),
                  Text(
                    "Rp ${totalBayar.toStringAsFixed(0)}",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFE91E63),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),

              // METODE, DIBAYAR, KEMBALIAN
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Metode"),
                  Text(metode),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Dibayar"),
                  Text("Rp ${nominal.toStringAsFixed(0)}"),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Kembalian"),
                  Text("Rp ${kembalian.toStringAsFixed(0)}"),
                ],
              ),

              const SizedBox(height: 10),
              const Divider(thickness: 1.2, color: Colors.black54),
              const SizedBox(height: 4),

              const Text(
                "☕ Terima kasih telah berbelanja di Cherry Coffee ☕",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 16),

              // TOMBOL TUTUP -> ke DASHBOARD
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.pop(context); // tutup dialog dulu
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    '/dashboard',
                    (route) => false,
                  ); // langsung ke dashboard
                },
                icon: const Icon(Icons.home, color: Colors.white),
                label: const Text(
                  "Kembali ke Dashboard",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFE91E63),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
