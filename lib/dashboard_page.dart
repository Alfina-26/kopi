import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final String? username =
        ModalRoute.of(context)?.settings.arguments as String?;

    return Scaffold(
      backgroundColor: const Color(0xFFFAF3E0),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xFF4B2E05),
        centerTitle: true,
        title: Text(
          "Cherry Coffee",
          style: GoogleFonts.playfairDisplay(
            fontWeight: FontWeight.bold,
            fontSize: 24,
            color: Colors.white,
          ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFFBEED7), Color(0xFFDCC5A2)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo + sapaan
                Column(
                  children: [
                    Image.asset(
                      'assets/logo1.png',
                      width: 90,
                      height: 90,
                    ),
                    const SizedBox(height: 14),
                    Text(
                      "Cherry Coffee",
                      style: GoogleFonts.playfairDisplay(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF4B2E05),
                        letterSpacing: 1.5,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      username != null && username.isNotEmpty
                          ? "Hai, $username 👋"
                          : "Selamat datang ☕",
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF5C4033),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      "Nikmati aroma kopi terbaik dari Cherry Coffee 🍒",
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: Colors.brown.shade700,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),

                const SizedBox(height: 40),

                // Menu Cards (kaca elegan)
                Wrap(
                  spacing: 25,
                  runSpacing: 25,
                  alignment: WrapAlignment.center,
                  children: [
                    _menuCard(context, Icons.local_cafe_rounded, "Produk", '/produk'),
                    _menuCard(context, Icons.info_outline_rounded, "Tentang Kami", '/about'),
                  ],
                ),

                const SizedBox(height: 45),

                // Tombol Logout
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/login');
                  },
                  icon: const Icon(Icons.logout_rounded, size: 20, color: Colors.white),
                  label: Text(
                    "Keluar",
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF6F4E37),
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    elevation: 5,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _menuCard(
      BuildContext context, IconData icon, String title, String route) {
    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: () => Navigator.pushNamed(context, route),
      child: Container(
        width: 150,
        height: 130,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          gradient: const LinearGradient(
            colors: [Color(0xFF8D6E63), Color(0xFF6F4E37)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.brown.withOpacity(0.4),
              blurRadius: 8,
              offset: const Offset(3, 5),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white, size: 40),
            const SizedBox(height: 10),
            Text(
              title,
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
