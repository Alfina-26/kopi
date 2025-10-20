import 'package:flutter/material.dart';
import 'produk_page.dart';

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
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            "============================\n      CHERRY COFFEE\nJl. Mawar No. 1, Bandung\n============================",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Courier',
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 10),
          Text("Metode Pembayaran: $metode",
              style: const TextStyle(fontSize: 16)),
          Text("Total Harga: Rp ${totalBayar.toStringAsFixed(0)}"),
          if (metode == 'Cash') ...[
            Text("Tunai: Rp ${nominal.toStringAsFixed(0)}"),
            Text("Kembalian: Rp ${kembalian.toStringAsFixed(0)}"),
          ],
          const SizedBox(height: 10),
          const Text(
            "============================\nTerima kasih sudah berbelanja!\n============================",
            textAlign: TextAlign.center,
            style: TextStyle(fontFamily: 'Courier', fontSize: 14),
          ),
          const SizedBox(height: 15),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.brown,
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onPressed: () {
              Navigator.pop(context); // Tutup struk popup
              Navigator.pop(context); // Kembali ke halaman sebelumnya
              Navigator.popUntil(context, (route) => route.isFirst); // ke Dashboard
            },
            child: const Text("Tutup", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
