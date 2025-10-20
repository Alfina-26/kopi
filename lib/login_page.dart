import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController userController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  bool _obscurePassword = true;
  String? _passwordError;

  bool _isPasswordValid(String password) {
    final hasLetter = password.contains(RegExp(r'[A-Za-z]'));
    final hasNumber = password.contains(RegExp(r'[0-9]'));
    return hasLetter && hasNumber;
  }

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
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Container(
            width: 400,
            padding: const EdgeInsets.all(30),
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
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset('assets/logo1.png', width: 90, height: 90),
                  const SizedBox(height: 15),

                  Text(
                    "Selamat Datang Kembali!",
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: espresso,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "Ngopi dulu sebelum mulai aktivitas ☕",
                    style: TextStyle(color: Colors.black54),
                  ),
                  const SizedBox(height: 30),

                  // Username
                  TextField(
                    controller: userController,
                    decoration: InputDecoration(
                      labelText: "Username",
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

                  // Password
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
                      errorText: _passwordError,
                    ),
                    onChanged: (value) {
                      setState(() {
                        _passwordError = null;
                      });
                    },
                  ),
                  const SizedBox(height: 25),

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
                        if (!_isPasswordValid(passController.text)) {
                          setState(() {
                            _passwordError =
                                "Password harus mengandung huruf dan angka";
                          });
                          return;
                        }

                        Navigator.pushReplacementNamed(
                          context,
                          '/dashboard',
                          arguments: userController.text,
                        );
                      },
                      child: const Text(
                        "Masuk Sekarang",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Belum punya akun? "),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacementNamed(context, '/register');
                        },
                        child: Text(
                          "Daftar Sekarang",
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
