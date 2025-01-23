import 'package:flutter/material.dart';
import 'package:sleepypandaapp/gender.dart'; // Pastikan import GenderPage

class NamaPage extends StatelessWidget {
  final TextEditingController _nameController = TextEditingController();

  NamaPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF20223F), // Background #20223F
      body: GestureDetector(
        onTap: () {
          // Kirim nama ke GenderPage saat layar diklik
          String name = _nameController.text;
          if (name.isNotEmpty) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => GenderPage(name: name), // Kirim nama
              ),
            );
          }
        },
        child: Stack(
          children: [
            // Teks: Selamat datang di Sleepy Panda!
            const Positioned(
              top: 70, // Atur posisi top
              left: 20, // Atur posisi left
              child: Text(
                'Selamat datang di Sleepy Panda!',
                style: TextStyle(
                  fontFamily: 'Urbanist',
                  fontWeight: FontWeight.w600, // Semibold
                  fontSize: 24,
                  color: Color(0xFFFBFBFB), // Warna teks #FBFBFB
                ),
              ),
            ),
            // Teks: Kita kenalan dulu yuk! Siapa nama
            const Positioned(
              top: 115, // Atur posisi top
              left: 20, // Atur posisi left
              child: Text(
                'Kita kenalan dulu yuk! Siapa nama',
                style: TextStyle(
                  fontFamily: 'Urbanist',
                  fontWeight: FontWeight.w400, // Regular
                  fontSize: 18,
                  color: Color(0xFFFBFBFB), // Warna teks #FBFBFB
                ),
              ),
            ),
            // Teks: kamu?
            const Positioned(
              top: 138, // Atur posisi top
              left: 20, // Atur posisi left
              child: Text(
                'kamu?',
                style: TextStyle(
                  fontFamily: 'Urbanist',
                  fontWeight: FontWeight.w400, // Regular
                  fontSize: 18,
                  color: Color(0xFFFBFBFB), // Warna teks #FBFBFB
                ),
              ),
            ),
            // Input Nama
            Positioned(
              top: 460,
              left: 55,
              child: SizedBox(
                width: 300,
                height: 50,
                child: TextField(
                  controller: _nameController,
                  style: const TextStyle(
                    fontFamily: 'Urbanist',
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFFFBFBFB),
                  ),
                  decoration: InputDecoration(
                    hintText: 'Masukkan nama',
                    hintStyle: TextStyle(
                      fontFamily: 'Urbanist',
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                      color:
                          const Color(0xFFFBFBFB).withOpacity(0.3), // Opacity 50%
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
