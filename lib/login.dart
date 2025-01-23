import 'package:flutter/material.dart';
import 'package:sleepypandaapp/nama.dart';
import 'loginregister.dart'; // Pastikan Anda mengimpor file loginregister.dart
import 'register.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;


class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _obscurePassword = true; // Untuk menyembunyikan password
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isButtonEnabled =
      false; // Menentukan apakah tombol bisa diklik atau tidak

  // Fungsi untuk memeriksa apakah email dan password sudah diisi
  void _checkInputs() {
    setState(() {
      // Tombol akan aktif jika email dan password tidak kosong
      _isButtonEnabled = _emailController.text.isNotEmpty &&
          _passwordController.text.isNotEmpty;
    });
  }

  Future<void> _login() async {
    final email = _emailController.text;
    final password = _passwordController.text;

    try {
      final response = await http.post(
        Uri.parse('http://127.0.0.1:8000/login/'), // Ganti dengan URL backend Anda
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print('Login Successful: ${data['message']}');
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => NamaPage()),
        );
      } else {
        final error = jsonDecode(response.body)['detail'];
        _showErrorDialog(error);
      }
    } catch (e) {
      _showErrorDialog('Failed to connect to the server');
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Error'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    // Menambahkan listener untuk memonitor perubahan pada input
    _emailController.addListener(_checkInputs);
    _passwordController.addListener(_checkInputs);
  }

  @override
  void dispose() {
    // Jangan lupa untuk dispose controller saat widget dihapus
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

void _showResetPasswordDialog() {
  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return Stack(
        children: [
          Positioned(
            bottom: -30, // Menempatkan dialog di bagian bawah
            left: 0,
            right: 0,
            child: Material(
              color: Colors.transparent, // Background transparan untuk dialog
              child: Container(
                width: double.infinity, // Lebar penuh
                height: 325,
                decoration: BoxDecoration(
                  color: Color(0xFF272E49),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                ),
                padding: EdgeInsets.all(10),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Tombol close
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context); // Menutup dialog
                        },
                        child: Container(
                          width: 50,
                          height: 4.5,
                          decoration: BoxDecoration(
                            color: Color(0xFF009090),
                            borderRadius: BorderRadius.circular(2),
                          ),
                          margin: EdgeInsets.only(bottom: 7),
                        ),
                      ),
                      Text(
                        'Lupa password?',
                        style: TextStyle(
                          fontFamily: 'Urbanist',
                          fontWeight: FontWeight.w600,
                          fontSize: 24,
                          color: Color(0xFFE7E7E7),
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Instruksi untuk melakukan reset password akan',
                        style: TextStyle(
                          fontFamily: 'Urbanist',
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        'dikirim melalui email yang kamu gunakan untuk',
                        style: TextStyle(
                          fontFamily: 'Urbanist',
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        'mendaftar',
                        style: TextStyle(
                          fontFamily: 'Urbanist',
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 23),
                      SizedBox(
                        width: 300,
                        height: 50,
                        child: TextField(
                          controller: _emailController,
                          style: const TextStyle(
                            fontFamily: 'Urbanist',
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF333333),
                          ),
                          decoration: InputDecoration(
                            hintText: 'Email',
                            hintStyle: const TextStyle(
                              fontFamily: 'Urbanist',
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                              color: Color(0xFF333333),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Color(0xFFF1F3FF), width: 2),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Color(0xFFF1F3FF), width: 2),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            filled: true,
                            fillColor: const Color(0xFFF1F3FF),
                            prefixIcon: Padding(
                              padding: const EdgeInsets.all(12),
                              child: Image.asset(
                                'images/email2.png',
                                width: 10,
                                height: 10,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 15),
                      Center(
                        child: GestureDetector(
                          onTap: () async {
                            final email = _emailController.text.trim();
                            if (email.isNotEmpty) {
                              final success = await requestOTP(email);
                              if (success) {
                                print("OTP request sent successfully.");
                                Navigator.pop(context); // Tutup dialog
                              } else {
                                print("Failed to send OTP.");
                              }
                            } else {
                              print("Email field is empty!");
                            }
                          },
                          child: Container(
                            width: 300,
                            height: 50,
                            decoration: BoxDecoration(
                              color: Color(0xFF009090),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              'Reset Password',
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
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      );
    },
  );
}

// Fungsi untuk request OTP
Future<bool> requestOTP(String email) async {
  final url = Uri.parse('http://localhost:8000/request-otp/');
  try {
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email}),
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      print("Response: ${responseData['message']}");
      return true; // Jika berhasil
    } else {
      final errorResponse = jsonDecode(response.body);
      print("Error: ${errorResponse['detail']}");
      return false;
    }
  } catch (e) {
    print("Failed to request OTP: $e");
    return false;
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
            // Teks Masuk menggunakan akun
            const Positioned(
              top: 322,
              left: 62,
              child: Text(
                'Masuk menggunakan akun yang',
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
              left: 105,
              child: Text(
                'sudah kamu daftarkan',
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
                onTap:
                    _showResetPasswordDialog, // Tampilkan dialog reset password
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
            // Tombol Masuk - Tombol Kustom
            Positioned(
              top: 730,
              left: 55,
              child: SizedBox(
                width: 306,
                height: 50,
                child: GestureDetector(
                  onTap: _isButtonEnabled ? _login : null,
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
                      'Masuk',
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
            // Teks Belum memiliki akun
            Positioned(
              top: 785,
              left: 95,
              child: Row(
                children: [
                  const Text(
                    'Belum memiliki akun? ',
                    style: TextStyle(
                      fontFamily: 'Urbanist',
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFFE7E7E7),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Register(),
                        ),
                      );
                    },
                    child: const Text(
                      'Daftar sekarang',
                      style: TextStyle(
                        fontFamily: 'Urbanist',
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF009090),
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
    home: Login(),
  ));
}
