import 'package:flutter/material.dart';
import 'loginregister.dart'; // Pastikan Anda mengimpor file loginregister.dart
import 'login.dart'; // Impor file Login.dart
import 'dart:convert';
import 'package:http/http.dart' as http;

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool _obscurePassword = true;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isButtonEnabled = false;

  void _checkInputs() {
    setState(() {
      _isButtonEnabled = _emailController.text.isNotEmpty &&
          _passwordController.text.isNotEmpty;
    });
  }

  @override
  void initState() {
    super.initState();
    _emailController.addListener(_checkInputs);
    _passwordController.addListener(_checkInputs);
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _registerUser() async {
    const url =
        'http://127.0.0.1:8000/register/'; // Sesuaikan dengan URL backend Anda
    final response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'email': _emailController.text,
        'password': _passwordController.text,
      }),
    );

    if (response.statusCode == 201) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Register Successful!')),
      );
      // Navigasi ke halaman login atau halaman lainnya
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Register Failed: ${response.body}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF20223F),
      body: Center(
        child: Stack(
          children: [
            // Gambar Panda
            Positioned(
              top: 197,
              left: 143,
              child: Image.asset(
                'images/panda.png',
                width: 128,
                height: 128,
              ),
            ),
            // Teks Daftar Menggunakan Email
            const Positioned(
              top: 322,
              left: 55,
              child: Text(
                'Daftar menggunakan email yang',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Urbanist',
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFFFBFBFB),
                ),
              ),
            ),
            // Teks valid
            const Positioned(
              top: 347,
              left: 180,
              child: Text(
                'valid',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Urbanist',
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFFFBFBFB),
                ),
              ),
            ),
            // Input Email
            Positioned(
              top: 460,
              left: 55,
              child: SizedBox(
                width: 300,
                height: 50,
                child: TextField(
                  controller: _emailController,
                  style: const TextStyle(
                    fontFamily: 'Urbanist',
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFFFBFBFB),
                  ),
                  decoration: InputDecoration(
                    hintText: 'Email',
                    hintStyle: const TextStyle(
                      fontFamily: 'Urbanist',
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                      color: Color(0xFFFBFBFB),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Color(0xFF272E49), width: 2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Color(0xFF272E49), width: 2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    filled: true,
                    fillColor: const Color(0xFF272E49),
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Image.asset(
                        'images/email.png',
                        width: 10,
                        height: 10,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            // Input Password
            Positioned(
              top: 525,
              left: 55,
              child: SizedBox(
                width: 300,
                height: 50,
                child: TextField(
                  controller: _passwordController,
                  obscureText: _obscurePassword,
                  style: const TextStyle(
                    fontFamily: 'Urbanist',
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFFFBFBFB),
                  ),
                  decoration: InputDecoration(
                    hintText: 'Password',
                    hintStyle: const TextStyle(
                      fontFamily: 'Urbanist',
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                      color: Color(0xFFFBFBFB),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Color(0xFF272E49), width: 2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Color(0xFF272E49), width: 2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    filled: true,
                    fillColor: const Color(0xFF272E49),
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Image.asset(
                        'images/password.png',
                        width: 10,
                        height: 10,
                      ),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscurePassword
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: const Color(0xFFFFFFFF),
                      ),
                      onPressed: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                    ),
                  ),
                ),
              ),
            ),
            // Teks Lupa Password
            Positioned(
              top: 580,
              left: 260,
              child: GestureDetector(
                onTap: () {
                  // Aksi lupa password
                  print("Lupa Password di-tap");
                },
                child: const Text(
                  'Lupa password?',
                  style: TextStyle(
                    fontFamily: 'Urbanist',
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF009090),
                  ),
                ),
              ),
            ),
            // Tombol Daftar
            Positioned(
              top: 730,
              left: 55,
              child: SizedBox(
                width: 306,
                height: 50,
                child: GestureDetector(
                  onTap: _isButtonEnabled ? _registerUser : null,
                  child: Container(
                    decoration: BoxDecoration(
                      color: _isButtonEnabled
                          ? const Color(0xFF009090) // Warna tombol aktif
                          : const Color(0x99009090), // Warna tombol nonaktif
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: const Color(0xFF009090)),
                    ),
                    alignment: Alignment.center,
                    child: const Text(
                      'Daftar',
                      style: TextStyle(
                        fontFamily: 'Urbanist',
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFFFBFBFB),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            // Teks Sudah Memiliki Akun? dan Masuk Sekarang
            Positioned(
              top: 785, // Posisi vertikal "Sudah Memiliki Akun?"
              left: 95, // Posisi horizontal "Sudah Memiliki Akun?"
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Sudah memiliki akun? ',
                    style: TextStyle(
                      fontFamily: 'Urbanist',
                      fontSize: 12,
                      fontWeight: FontWeight.w600, // Semibold
                      color: Color(0xFFE7E7E7), // Warna #E7E7E7
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      // Navigasi ke halaman Login
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Login()),
                      );
                    },
                    child: const Text(
                      'Masuk sekarang',
                      style: TextStyle(
                        fontFamily: 'Urbanist',
                        fontSize: 12,
                        fontWeight: FontWeight.w400, // Regular
                        color: Color(0xFF009090), // Warna #009090
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Register(),
  ));
}
