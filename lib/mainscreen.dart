import 'package:flutter/material.dart';
import 'loginregister.dart'; // Pastikan Anda mengimpor file loginregister.dart

class Slide1 extends StatefulWidget {
  @override
  _Slide1State createState() => _Slide1State();
}

class _Slide1State extends State<Slide1> {
  // Jika ada data dinamis atau perubahan UI, bisa disimpan di sini
  bool isClicked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF20223F), // Background color
      body: GestureDetector(
        onTap: () {
          // Navigasi ke halaman loginregister.dart saat layar diketuk
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    LoginRegister()), // Pindah ke LoginRegister
          );
        },
        child: Center(
          child: Stack(
            children: [
              // Gambar panda yang dapat dipindahkan
              Positioned(
                top: 310, // Posisi gambar dari atas
                left: 138, // Posisi gambar dari kiri
                child: Image.asset(
                  'images/panda.png', // Pastikan file ada di folder 'assets'
                  width: 128, // Ukuran gambar disesuaikan jika perlu
                  height: 128,
                ),
              ),
              // Teks Sleepy Panda dengan bayangan
              const Positioned(
                top: 421, // Posisi teks dari atas
                left: 73, // Posisi teks dari kiri
                child: Stack(
                  children: [
                    Text(
                      'Sleepy Panda',
                      style: TextStyle(
                        fontFamily: 'Urbanist',
                        fontSize: 40,
                        fontWeight: FontWeight.w900,
                        color: Color(0xFFFBFBFB), // Warna teks putih
                        shadows: [
                          Shadow(
                            blurRadius:
                                2.5, // Meningkatkan blur untuk bayangan yang lebih lembut
                            offset:
                                Offset(0.0, 5.0), // Bayangan mengarah ke bawah
                            color: Color.fromARGB(
                                70, 0, 0, 0), // Warna bayangan hitam transparan
                          ),
                          Shadow(
                            blurRadius:
                                2.0, // Meningkatkan blur untuk bayangan yang lebih lembut
                            offset: Offset(
                                0.0, 2.5), // Bayangan lebih jauh ke bawah
                            color: Color.fromARGB(
                                70, 0, 0, 0), // Warna bayangan hitam transparan
                          ),
                          Shadow(
                            blurRadius:
                                3.0, // Meningkatkan blur untuk bayangan yang lebih lembut
                            offset: Offset(
                                0.0, 5.5), // Bayangan lebih jauh ke bawah
                            color: Color.fromARGB(
                                70, 0, 0, 0), // Warna bayangan hitam transparan
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Slide1(),
  ));
}
