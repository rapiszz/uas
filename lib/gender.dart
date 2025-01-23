import 'package:flutter/material.dart';
import 'tanggallahir.dart'; // Import halaman TanggalLahir
import 'package:http/http.dart' as http;
import 'dart:convert'; // Untuk mengolah JSON

class GenderPage extends StatefulWidget {
  final String name; // Menambahkan parameter untuk menerima nama

  const GenderPage({Key? key, required this.name})
      : super(key: key); // Konstruktor untuk menerima nama

  @override
  State<GenderPage> createState() => _GenderPageState();
}

class _GenderPageState extends State<GenderPage> {
  String? selectedGender; // Menyimpan gender yang dipilih

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF20223F), // Background #20223F
      body: GestureDetector(
        onTap: () {
          if (selectedGender != null) {
            // Navigasi ke halaman TanggalLahir jika gender dipilih
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => TanggalLahirApp(),
              ),
            );
          }
        },
        child: Stack(
          children: [
            // Teks: Hi Serena! --> Diubah menjadi Hi {name} sesuai input
            Positioned(
              top: 70, // Atur posisi top
              left: 20, // Atur posisi left
              child: Text(
                'Hi ${widget.name}!', // Menampilkan nama yang diterima
                style: const TextStyle(
                  fontFamily: 'Urbanist',
                  fontWeight: FontWeight.w600, // Semibold
                  fontSize: 24,
                  color: Color(0xFFFBFBFB), // Warna teks #FBFBFB
                ),
              ),
            ),
            // Teks lainnya dan tombol gender tetap seperti sebelumnya
            const Positioned(
              top: 115, // Atur posisi top
              left: 20, // Atur posisi left
              child: Text(
                'Pilih gender kamu, agar kami bisa mengenal',
                style: TextStyle(
                  fontFamily: 'Urbanist',
                  fontWeight: FontWeight.w400, // Regular
                  fontSize: 18,
                  color: Color(0xFFFBFBFB), // Warna teks #FBFBFB
                ),
              ),
            ),
            const Positioned(
              top: 138,
              left: 20,
              child: Text(
                'kamu lebih baik.',
                style: TextStyle(
                  fontFamily: 'Urbanist',
                  fontWeight: FontWeight.w400,
                  fontSize: 18,
                  color: Color(0xFFFBFBFB),
                ),
              ),
            ),
            // Tombol Gender - Wanita
            Positioned(
              top: 430,
              left: 55,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    selectedGender = 'Wanita';
                  });
                },
                child: Container(
                  width: 300,
                  height: 50,
                  decoration: BoxDecoration(
                    color: const Color(
                        0xFF272E49), // Warna latar dalam border tetap #272E49
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: selectedGender == 'Wanita'
                          ? const Color(
                              0xFF009090) // Warna border aktif saat dipilih #009090
                          : const Color(
                              0xFF272E49), // Warna border default #272E49
                      width: 2,
                    ),
                  ),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Image.asset(
                          'images/Wanita.png',
                          width: 20,
                          height: 20,
                        ),
                      ),
                      const Text(
                        'Wanita',
                        style: TextStyle(
                          fontFamily: 'Urbanist',
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFFFBFBFB),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // Tombol Gender - Pria
            Positioned(
              top: 495,
              left: 55,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    selectedGender = 'Pria';
                  });
                },
                child: Container(
                  width: 300,
                  height: 50,
                  decoration: BoxDecoration(
                    color: const Color(
                        0xFF272E49), // Warna latar dalam border tetap #272E49
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: selectedGender == 'Pria'
                          ? const Color(
                              0xFF009090) // Warna border aktif saat dipilih #009090
                          : const Color(
                              0xFF272E49), // Warna border default #272E49
                      width: 2,
                    ),
                  ),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Image.asset(
                          'images/Pria.png',
                          width: 20,
                          height: 20,
                        ),
                      ),
                      const Text(
                        'Pria',
                        style: TextStyle(
                          fontFamily: 'Urbanist',
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFFFBFBFB),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: GenderPage(
        name:
            "Serena"), // Hanya sebagai default, agar app tetap berjalan saat testing
  ));
}
