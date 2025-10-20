import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    const Color espresso = Color(0xFF4B2E05);
    const Color mocha = Color(0xFFA47551);
    const Color latte = Color(0xFFDCC7AA);

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [latte, mocha, espresso],
            begin: Alignment.topCenter,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              width: 400,
              padding: const EdgeInsets.all(30),
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.97),
                borderRadius: BorderRadius.circular(25),
                boxShadow: [
                  BoxShadow(
                    color: espresso.withOpacity(0.3),
                    blurRadius: 20,
                    spreadRadius: 3,
                    offset: const Offset(6, 8),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // ===== LOGO =====
                  Image.asset('assets/logo1.png', width: 90, height: 90),
                  const SizedBox(height: 15),

                  Text(
                    "Buat Akun Baru",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: espresso,
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    "Gabung dan nikmati pengalaman ngopi terbaik ☕",
                    style: TextStyle(color: Colors.black54),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 30),

                  // ===== Nama Lengkap =====
                  TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                      labelText: "Nama Lengkap",
                      prefixIcon:
                          const Icon(Icons.person, color: Color(0xFF4B2E05)),
                      filled: true,
                      fillColor: latte.withOpacity(0.5),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderSide:
                            BorderSide(color: espresso, width: 2),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),

                  // ===== Email =====
                  TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                      labelText: "Email",
                      prefixIcon:
                          const Icon(Icons.email, color: Color(0xFF4B2E05)),
                      filled: true,
                      fillColor: latte.withOpacity(0.5),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderSide:
                            BorderSide(color: espresso, width: 2),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),

                  // ===== Password =====
                  TextField(
                    controller: passController,
                    obscureText: _obscurePassword,
                    decoration: InputDecoration(
                      labelText: "Password",
                      prefixIcon:
                          const Icon(Icons.lock, color: Color(0xFF4B2E05)),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscurePassword
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: espresso,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscurePassword = !_obscurePassword;
                          });
                        },
                      ),
                      filled: true,
                      fillColor: latte.withOpacity(0.5),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderSide:
                            BorderSide(color: espresso, width: 2),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),

                  // ===== Tombol Register =====
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: espresso,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      onPressed: () {
                        final name = nameController.text.trim();
                        final email = emailController.text.trim();
                        final password = passController.text;

                        if (name.isEmpty || email.isEmpty || password.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text("Semua field harus diisi!")),
                          );
                          return;
                        }

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text("Pendaftaran Berhasil! 🎉")),
                        );

                        Future.delayed(const Duration(seconds: 1), () {
                          Navigator.pushReplacementNamed(context, '/login');
                        });
                      },
                      child: const Text(
                        "Daftar Sekarang",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Sudah punya akun? "),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacementNamed(context, '/login');
                        },
                        child: Text(
                          "Masuk",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: espresso),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
