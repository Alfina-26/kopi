import 'package:flutter/material.dart';

class TentangPage extends StatelessWidget {
  const TentangPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tentang Cherry Coffee'),
        backgroundColor: Colors.brown,
        centerTitle: true,
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/coffee_bg.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Container(
            padding: const EdgeInsets.all(20),
            margin: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.95),
              borderRadius: BorderRadius.circular(20),
              boxShadow: const [
                BoxShadow(
                  color: Colors.brown,
                  blurRadius: 10,
                  spreadRadius: 2,
                  offset: Offset(3, 5),
                ),
              ],
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    "Cherry Coffee",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.brown,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Tempat terbaik untuk menikmati kopi berkualitas premium "
                    "dengan suasana hangat dan pelayanan penuh senyum ☕🍒",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16, color: Colors.black87),
                  ),
                  const SizedBox(height: 25),

                  // ======= Bagian Rating =======
                  const Text(
                    "Rating Pengunjung Kami",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.brown,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.star, color: Colors.amber, size: 30),
                      Icon(Icons.star, color: Colors.amber, size: 30),
                      Icon(Icons.star, color: Colors.amber, size: 30),
                      Icon(Icons.star, color: Colors.amber, size: 30),
                      Icon(Icons.star_half, color: Colors.amber, size: 30),
                    ],
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    "4.5 / 5.0 dari 1.248 ulasan",
                    style: TextStyle(fontSize: 15, color: Colors.grey),
                  ),
                  const SizedBox(height: 20),

                  // ======= Bagian Ulasan Pelanggan =======
                  const Text(
                    "Apa Kata Pengunjung?",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.brown,
                    ),
                  ),
                  const SizedBox(height: 12),
                  _buildReview(
                    "Rani P.",
                    "Tempatnya cozy banget buat nongkrong dan nugas. Kopinya juga enak banget!",
                    5,
                  ),
                  _buildReview(
                    "Andi S.",
                    "Pelayanannya cepat dan baristanya ramah. Latte-nya recommended.",
                    4,
                  ),
                  _buildReview(
                    "Dewi A.",
                    "Cherry Latte-nya unik, rasa manisnya pas. Bakal balik lagi!",
                    5,
                  ),
                  const SizedBox(height: 25),

                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back),
                    label: const Text("Kembali ke Dashboard"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.brown,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ==== Widget untuk Review Pengunjung ====
  Widget _buildReview(String name, String comment, int rating) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.brown.withOpacity(0.08),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.person, size: 35, color: Colors.brown),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.brown,
                    fontSize: 16,
                  ),
                ),
                Row(
                  children: List.generate(
                    rating,
                    (index) => const Icon(Icons.star,
                        size: 18, color: Colors.amber),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  comment,
                  style: const TextStyle(fontSize: 14, color: Colors.black87),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
